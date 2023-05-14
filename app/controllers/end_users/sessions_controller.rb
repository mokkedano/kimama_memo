class EndUsers::SessionsController < ApplicationController


  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to my_page_path(end_user), notice: 'ゲストユーザーでログインしました！'
  end


end
