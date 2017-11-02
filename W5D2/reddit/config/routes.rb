Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
    resources :votes, only: [:create]
  end
  resources :comments, only: [:create, :show]

end
