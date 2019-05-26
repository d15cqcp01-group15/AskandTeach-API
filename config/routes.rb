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
  get '/all_course', to: 'courses#index'

  get '/user_course', to: 'courses#user_course'
  get 'joined_course', to: 'courses#joined_course'
  post 'close_course', to: 'courses#close_course'

  get '/user_event', to: 'events#user_event'
  get 'joined_event', to: 'events#joined_event'

  get '/*a', to: 'application#not_found'
end
