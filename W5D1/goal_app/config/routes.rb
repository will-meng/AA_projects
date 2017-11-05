Rails.application.routes.draw do
  get 'goals/new'

  get 'goals/create'

  get 'goals/show'

  get 'goals/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:create, :new, :destroy]
  resources :users
  resources :goals
end
