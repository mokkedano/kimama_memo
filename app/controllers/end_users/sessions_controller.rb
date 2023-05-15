class EndUsers::SessionsController < ApplicationController


  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to my_page_path, notice: 'ゲストユーザーでログインしました！'
  end


end
