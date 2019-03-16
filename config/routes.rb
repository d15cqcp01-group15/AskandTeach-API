Rails.application.routes.draw do
  resources :courses
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'users#create'
  get '/*a', to: 'application#not_found'
end
