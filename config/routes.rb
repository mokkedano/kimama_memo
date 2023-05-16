Rails.application.routes.draw do


  # 会員側
  devise_for :end_users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :end_user do
    post "end_users/guest_sign_in", to: "end_users/sessions#guest_sign_in"
  end


  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    resources :categories, except: [:destroy]

    # end_users コントローラー
    get "/end_users/my_page" => "end_users#show", as: "my_page"
    get "/end_users/information/edit" => "end_users#edit"
    patch "/end_users/information" => "end_users#update"
    get "/end_users/unsubscribe" => "end_users#unsubscribe", as: "unsubscribe"
    patch "/end_users/withdrawal" => "end_users#withdrawal", as: "withdrawal"
    get "/end_users/favorites" => "end_users#favorites", as: "favorite_index"

    # posts コントローラー
    # get "/posts/memo" => "posts#memo_index", as: "memo"
    get "posts/search_category"=>"posts#search_category"
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    # searchesコントローラー
    get "search" => "searches#search"

    # groupsコントローラー
    get "group_all" => "groups#group_all"
    resources :groups do
      get "join" => "groups#join"
      delete "destroy_all" => 'groups#destroy_all'
    end

  end





  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    root :to => "homes#top"
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :end_users, only: [:index, :show, :edit, :update] do
      get "posts" => "end_users#posts"
      resources :comments, only: [:index, :destroy]
    end
  end


end
