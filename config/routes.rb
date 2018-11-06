Rails.application.routes.draw do
  get 'problem/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api/v1' do
    get '/problems', to: 'problems#index'
  end
end
