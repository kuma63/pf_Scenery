Rails.application.routes.draw do
  devise_for :users, controllers: {
   sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :photos, only: [:create, :index, :show, :edit, :update, :destroy] do
    member do
      get 'photo_map' => 'photos#photo_map', as: 'photo_map'
    end

    resource :favorites, only: [:create, :destroy]
    resources :photo_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'search' => 'searches#search'
  # タグ検索用
  get 'tags_search' => 'photos#tags_search'

end
