Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users
# 親子関係
  resources :books, only: [:index, :show, :create, :edit, :destroy ,:create ,:update] do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :show, :index, :edit, :update, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
