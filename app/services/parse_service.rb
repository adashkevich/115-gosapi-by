# encoding: utf-8
require 'open-uri'

class ParseService

  def process
    City.all.each do |city|
      for_month = city.from.at_beginning_of_month
      while for_month <= Date.today.at_beginning_of_month
        process_city city.id, for_month
        for_month = for_month.next_month
      end
    end
  end

  def process_city(city_id, month)
    data = get_data city_id, month
    data['items'].each do |problem_id, problem|
      save_user problem['user']
      save_category problem['category']
      save_problem problem
    end
  end

  def get_data(city_id, date)
    response = HTTP.get 'http://115.xn--90ais'
    token = get_token response
    response = HTTP.cookies(response.cookies).post "http://115.xn--90ais/city/change/#{city_id}",
                                        form: {_token: token, _fgp: '92fda86127f364596b1d452e4e7960b3'}
    response = HTTP.cookies(response.cookies).post 'http://115.xn--90ais/api/problem/getlist',
                                                   form: {_token: token, date: date.strftime('%F')}
    JSON.parse response.body.to_s
  end

  def get_token(response)
    response_body = Nokogiri::HTML response.body.to_s
    token_input = response_body.css '[name="_token"]'
    token_input.attribute('value').to_s
  end

  def save_user(json)
    user_json = json.slice 'id', 'name', 'last_name', 'middle_name'
    User.create user_json if User.where(id: user_json['id']).empty?
  end

  def save_category(json)
    category_json = json.slice 'id', 'parent_id', 'icon'
    Category.create category_json if Category.where(id: category_json['id']).empty?
  end

  def save_problem(json)
    problem_id = json['id']
    problem_json = create_problem_json json

    problem = Problem.where(id: problem_id).first
    if problem.nil?
      problem_json.merge!(description: problem_description(problem_id))
      problem = Problem.create problem_json

      if problem.status == '5'
        parse_answer problem_id
        problem.update! date_solve: DateTime.now
      end
    else
      if problem_json['organisation_id'] != problem.organisation_id
        ChangeLog.create field: 'organisation_id', old: problem.organisation_id, new: problem_json['organisation_id'], problem_id: problem_id
      end

      if problem_json['status'] != problem.status
        ChangeLog.create field: 'status', old: problem.status, new: problem_json['status'], problem_id: problem_id
        parse_answer problem_id if problem_json['status'] == '7' || problem_json['status'] == '5'
      end

      if changed? problem_json, problem
        problem_json.merge! date_solve: DateTime.now if solved? problem_json, problem
        Problem.find(problem_id).update problem_json
      end
    end
  end

  def create_problem_json(json)
    json.slice('id', 'href', 'address', 'date_create', 'organisation_id', 'status', 'rating').merge(
        date_planned: Date.strptime(json['date_planned'], '%d.%m.%Y'),
        crm_date_planned: Date.strptime(json['crm_date_planned'], '%Y-%m-%d'),
        crm_create_at: Date.strptime(json['crm_create_at'], '%Y-%m-%d'),
        user_id: json['user']['id'],
        category_id: json['category']['id'],
        location: "POINT(#{json['lng']} #{json['lat']})"
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

  def parse_answer(problem_id)
    begin
      problem_page = Nokogiri::HTML(open "http://115.xn--90ais/problem/#{problem_id}")
      answers = problem_page.css '.b-user-problem__answer__main'

      answers.each do |answer|
        title = answer.css '.b-answer__title'
        text = answer.css '.b-answer__main__text__itm'
        publish_date = answer.css '.b-answer__main__text__publish__itm__date'
        is_organization = answer.css('[assessment]').empty?

        if !title.empty? && !text.empty? && !publish_date.empty?
          Answer.create organization: title[0].text, text: text[0].text,
                        publish_date: parse_answer_publish_date(publish_date[0].text),
                        problem_id: problem_id, is_organization: is_organization
        else
          p "some answer for problem #{problem_id} hasn't all attributes"
        end
      end
    rescue Exception
      p "answers parsing for problem #{problem_id} failed"
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

  def solved?(problem_json, problem)
    problem_json['status'] != problem.status && problem_json['status'] == '5'
  end
end