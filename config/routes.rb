Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    get '/problems', to: 'problems#index'

    scope '/open_data' do
      get '/problems', to: 'open_data#problems'
      get '/users', to: 'open_data#users'
      get '/organizations', to: 'open_data#organizations'
      get '/categories', to: 'open_data#categories'
    end
  end
end
