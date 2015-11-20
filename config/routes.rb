Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resource :sessions, only: [:new, :create, :destroy] 
end
