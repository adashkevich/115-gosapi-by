Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    get '/problems', to: 'problems#index'

    scope '/open_data' do
      get '/problems', to: 'charts#problems'
      get '/users', to: 'charts#users'
      get '/organizations', to: 'charts#organizations'
      get '/categories', to: 'charts#categories'
    end
  end
end
