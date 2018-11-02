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
    problem_json = json.slice('id', 'href', 'address', 'date_create', 'organisation_id', 'status', 'rating').merge(
      date_planned: Date.strptime(json['date_planned'], '%d.%m.%Y'),
      crm_date_planned: Date.strptime(json['crm_date_planned'], '%Y-%m-%d'),
      crm_create_at: Date.strptime(json['crm_create_at'], '%Y-%m-%d'),
      user_id: json['user']['id'],
      category_id: json['category']['id'],
      location: "POINT(#{json['lng']} #{json['lat']})"
    )

    Problem.where(id: problem_json['id']).first_or_create! problem_json
  end
end