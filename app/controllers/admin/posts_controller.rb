class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :destroy]


  def index
    @posts = Post.all.order('id DESC').page(params[:page]).per(10)
  end


  def show
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

