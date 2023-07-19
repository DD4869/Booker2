Rails.application.routes.draw do
  # devise_forは最初に記述する（最後に記述するとshowにリダイレクトされる）
  devise_for :users
  root to: 'homes#top'
  #homes/about -> home/about
  resources :homes, only: [], path: 'home' do
    get 'about', on: :collection
  end

  # いいねとコメントはBookに対してされるためネスト
  resources :books, only:[:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
