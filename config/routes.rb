Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    get '/problems', to: 'problems#index'
    #get '/charts/problems_count_per_day'
    get '/charts/problems_by_organization'
    get '/charts/unsolved_problems_by_organization'
    get '/charts/problems_by_category'
    get '/charts/unsolved_problems_by_category'
    get '/charts/new_problems_per_day'

    get '/charts/problems'
    get '/charts/users'
    get '/charts/organizations'
    get '/charts/categories'
  end
end
