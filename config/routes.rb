Rails.application.routes.draw do
  resources :topics
  resources :detail_events
  resources :events
  resources :detail_courses
  resources :courses
  resources :users, param: :_username

  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'users#create'

  get '/*a', to: 'application#not_found'
end
