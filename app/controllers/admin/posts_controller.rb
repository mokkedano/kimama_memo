class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]


  def index
    @posts = Post.all
  end


  def show
    @end_user = EndUser.find(params[:id])
  end


  def destroy
    if @post.destroy
      redirect_to admin_posts_path, notice: "会員メモを管理者権限で削除しました。"
    else
      render :show
    end
  end



  private
  def set_post
    @post = Post.find(params[:id])
  end
end

