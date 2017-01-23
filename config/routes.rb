Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/signup' => 'users#new'
  post '/users' => 'users#edit'
  patch '/users' => 'users#update'
  get '/triage' => 'users#show'
  post '/firstq' => 'users#question_one'
  post '/acstriage' => 'users#acs'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'



end
