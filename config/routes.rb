Rails.application.routes.draw do


  # 会員側
  devise_for :end_users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


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

    # posts コントローラー
    get "/posts/memo" => "posts#memo_index", as: "memo"
    resources :posts

  end





  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    root :to => "homes#top"
    resources :end_users, only: [:index, :show, :edit, :update]
    # resources :comments, only: [:index, :show, :destroy]
  end


end
