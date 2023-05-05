Rails.application.routes.draw do


  # 会員側
  devise_for :end_users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


end
