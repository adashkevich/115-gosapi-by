# encoding: utf-8
require 'open-uri'

class ParseService

  def process
    prepare
    City.all.each do |city|
      for_month = city.from.at_beginning_of_month
      credentials = choose_city city.id
      @city = city
      while for_month <= Date.today.at_beginning_of_month
        process_month credentials, for_month
        for_month = for_month.next_month
      end
    end
  end

  def parse_answer(problem)
    begin
      problem_page = Nokogiri::HTML(open "http://115.xn--90ais/problem/#{problem.id}")
      answers = problem_page.css '.b-user-problem__answer__main'

      answers.each_with_index do |answer, index|
        if index >= problem.answers_count
          title = answer.css '.b-answer__title'
          text = answer.css '.b-answer__main__text__itm'
          publish_date = answer.css '.b-answer__main__text__publish__itm__date'
          is_organization = answer.css('[assessment]').empty?

          if !title.empty? && !text.empty? && !publish_date.empty?
            Answer.create organization: title[0].text, text: text[0].text,
                          publish_date: parse_answer_publish_date(publish_date[0].text),
                          problem_id: problem.id, is_organization: is_organization
          else
            p "some answer for problem #{problem.id} hasn't all attributes"
          end
        end
      end
      return answers.count
    rescue Exception
      p "answers parsing for problem #{problem.id} failed"
    end
    problem.answers_count
  end

  private

  def prepare
    @categories = Category.pluck(:id)
    @users = User.pluck(:id)
  end

  def process_month(creds, month)
    data = get_data creds, month
    problems = Problem.where(city_id: @city.id, crm_create_at: month...month.next_month)
    FetchLog.create! data: data, fetch_for: month
    data['items'].each do |problem_id, problem|
      save_user problem['user']
      save_category problem['category']
      save_problem problem, problems
    end
  end

  def choose_city(city_id)
    response = HTTP.get 'http://115.xn--90ais'
    token = get_token response
    response = HTTP.cookies(response.cookies).post "http://115.xn--90ais/city/change/#{city_id}",
                                                   form: {_token: token, _fgp: '92fda86127f364596b1d452e4e7960b3'}
    {token: token, cookies: response.cookies}
  end

  def get_data(creds, date)
    response = HTTP.cookies(creds[:cookies]).post 'http://115.xn--90ais/api/problem/getlist',
                                                   form: {_token: creds[:token], date: date.strftime('%F')}
    JSON.parse response.body.to_s
  end

  def get_token(response)
    response_body = Nokogiri::HTML response.body.to_s
    token_input = response_body.css '[name="_token"]'
    token_input.attribute('value').to_s
  end

  def save_user(json)
    user_json = json.slice 'id', 'name', 'last_name', 'middle_name'
    unless @users.include? user_json['id'].to_i
      User.create user_json
      @users << user_json['id'].to_i
    end
  end

  def save_category(json)
    category_json = json.slice 'id', 'parent_id', 'icon'
    unless @categories.include? category_json['id'].to_i
      Category.create category_json
      @categories << category_json['id'].to_i
    end
  end

  def save_problem(json, problems)
    problem_id = json['id'].to_i
    problem_json = create_problem_json json

    problem = problems.index {|p| p.id == problem_id }
    if problem.nil?
      problem_json.merge!(description: problem_description(problem_id), city_id: @city.id)
      problem = Problem.create problem_json

      if problem_json['status'] == '7' || problem_json['status'] == '5'
        answers_count = parse_answer problem
        problem.update answers_count: answers_count unless answers_count == 0
      end
    else
      problem = problems[problem]
      if problem_json['organisation_id'] != problem.organisation_id
        ChangeLog.create field: 'organisation_id', old: problem.organisation_id, new: problem_json['organisation_id'], problem_id: problem_id
      end

      if problem_json['status'] != problem.status
        ChangeLog.create field: 'status', old: problem.status, new: problem_json['status'], problem_id: problem_id
      end

      if changed? problem_json, problem
        problem_json.merge! answers_count: parse_answer(problem)
        problem.update problem_json
      end
    end
    problem
  end

  def create_problem_json(json)
    json.slice('id', 'href', 'address', 'date_create', 'organisation_id', 'status', 'rating').merge(
        'date_planned' => Date.strptime(json['date_planned'], '%d.%m.%Y'),
        'crm_date_planned' => Date.strptime(json['crm_date_planned'], '%Y-%m-%d'),
        'crm_create_at' => Date.strptime(json['crm_create_at'], '%Y-%m-%d'),
        'user_id' => json['user']['id'],
        'category_id' => json['category']['id'],
        'location' => "POINT(#{json['lng']} #{json['lat']})",
    )
  end

  def problem_description(problem_id)
    begin
      problem_page = Nokogiri::HTML(open "http://115.xn--90ais/problem/#{problem_id}")
      problem_page.css('.b-current-problem__middle p')[0].text
    rescue OpenURI::HTTPError
      p "problem #{problem_id} doesn't exist"
    end
  end

  def parse_answers
    Problem.where(status: '5').each do |problem|
      parse_answer problem.id if problem.answers.empty?
    end
  end

  def parse_answer_publish_date(publish_date)
    DateTime.parse(publish_date.gsub(/октября|ноября|декабря|января|февраля/, 'октября' => 'Oct', 'ноября' => 'Nov', 'декабря' => 'Dec', 'февраля' => 'Feb'), '%d %b %H:%M')
  end

  def changed?(problem_json, problem)
    problem_json['organisation_id'] != problem.organisation_id ||
        problem_json['status'] != problem.status ||
        problem_json['rating'].to_i != problem.rating
  end
end