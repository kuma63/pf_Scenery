Rails.application.routes.draw do
  # ゲストユーザーが削除機能を使用できないようにするためのルーティング
  devise_for :users, controllers: {
   registrations: 'users/registrations'
  }
  # デバイスにルーティングを追加する
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :photos, only: [:create, :index, :show, :photo_map, :edit, :update, :destroy] do

    resource :favorites, only: [:create, :destroy]
    resources :photo_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :withdrawal] do
    member do
      get :favorites
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'users_search' => 'searches#users_seach'
  get 'photos_search' => 'searches#photos_search'
  get 'tags_search' => 'searches#tags_search'

end
