require 'open-uri'

class ParseService

  def process(file_path)
    data = JSON.parse File.read(file_path)
    p data
    data['items'].each do |problem_id, problem|
      save_user problem['user']
      save_category problem['category']
      save_problem problem
    end
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
    problem_json = json.slice('id', 'href', 'address', 'date_create', 'organisation_id', 'status', 'rating').merge(
      date_planned: Date.strptime(json['date_planned'], '%d.%m.%Y'),
      crm_date_planned: Date.strptime(json['crm_date_planned'], '%Y-%m-%d'),
      crm_create_at: Date.strptime(json['crm_create_at'], '%Y-%m-%d'),
      user_id: json['user']['id'],
      category_id: json['category']['id'],
      location: "POINT(#{json['lng']} #{json['lat']})"
    )

      problem = Problem.where(id: problem_id).first
      if problem.nil?
        problem_json.merge!(description: problem_description(problem_id))
        problem = Problem.create problem_json

        if problem.status == '5'
          parse_answer problem_id
        end
      else
        if problem_json['organisation_id'] != problem.organisation_id
          ChangeLog.create field: 'organisation_id', old: problem.organisation_id, new: problem_json['organisation_id'], problem_id: problem_id
        end

        if problem_json['status'] != problem.status
          ChangeLog.create field: 'status', old: problem.status, new: problem_json['status'], problem_id: problem_id

          if problem_json['status'] == '5'
            parse_answer problem_id
          end
        end

        if changed? problem_json, problem
          Problem.find(problem_id).update problem_json
        end
      end
    # Problem.where(id: problem_id).first_or_create! problem_json
  end

  def problem_description(problem_id)
    problem_page = Nokogiri::HTML(open "http://115.xn--90ais/problem/#{problem_id}")
    problem_page.css('.b-current-problem__middle p')[0].text
  end

  def parse_answer(problem_id)
    p "parse answer for problem #{problem_id}"
    problem_page = Nokogiri::HTML(open "http://115.xn--90ais/problem/#{problem_id}")
    answers = problem_page.css '.b-user-problem__answer__main'

    answers.each do |answer|
      title = answer.css '.b-answer__title'
      text = answer.css '.b-answer__main__text__itm'

      if !title.empty? && !text.empty?
        Answer.create organization: title[0].text, text: text[0].text, problem_id: problem_id
      end
    end
  end

  def parse_answers
    Problem.where(status: '5').each do |problem|
      parse_answer problem.id if problem.answers.empty?
    end
  end

  def changed?(problem_json, problem)
    problem_json['organisation_id'] != problem.organisation_id ||
      problem_json['status'] != problem.status ||
      problem_json['rating'].to_i != problem.rating
  end
end