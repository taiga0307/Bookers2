Rails.application.routes.draw do
  devise_for :users
  root 'books#top'

  resources :books, only: [:index, :show, :create, :destroy]
  resources :users, only: [:new, :show, :index, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
