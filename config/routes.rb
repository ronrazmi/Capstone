Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/home' => 'users#home'
  get '/signup' => 'users#new'
  post '/users' => 'users#edit'
  patch '/users' => 'users#update'
  get '/triage' => 'users#show'
  post '/firstq' => 'users#question_one'
  post '/acstriage' => 'users#acs'
  post '/utitriage' => 'users#uti'
  get '/benefits' => 'users#benefits'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :conversations do
    resources :messages
  end



end
