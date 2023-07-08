Rails.application.routes.draw do
  # devise_forは最初に記述する（最後に記述するとshowにリダイレクトされる）
  devise_for :users
  root to: 'homes#top'
  get '/homes/about' => 'homes#about', as: 'about'

  resources :books
  resources :users, only: [:show, :edit, :update, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end