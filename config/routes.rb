Rails.application.routes.draw do
  resources :topics
  resources :detail_events
  resources :events
  resources :detail_courses
  resources :courses
  resources :users

  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'users#create'
  delete '/unregister_course', to: 'detail_courses#delete_register'

  get '/*a', to: 'application#not_found'
end
