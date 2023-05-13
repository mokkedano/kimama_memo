class Admin::EndUsersController < ApplicationController


  def index
    @end_users = EndUser.all
  end


  def show
    @end_user = EndUser.find(params[:id])
  end




  private
  def end_user_params
    params.require(:end_user).permit(:nickname, :email, :self_introduction, :is_deleted)
  end


end
