class Admin::EndUsersController < ApplicationController
  before_action :set_end_user, only: [:show, :edit, :update]


  def index
    @end_users = EndUser.all
  end


  def show
  end


  def edit
  end


  def update
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user), notice: "会員プロフィールを更新しました！"
    else
      render :edit
    end
  end


  def posts
    @end_user = EndUser.find(params[:end_user_id])
    @posts = @end_user.posts
  end




  private
  def end_user_params
    params.require(:end_user).permit(:nickname, :email, :self_introduction, :is_deleted, :profile_image)
  end


  def set_end_user
    @end_user = EndUser.find(params[:id])
  end


end
