class Public::PostsController < ApplicationController


  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path
  end





  private
  def post_params
    params.repuire(:post).permit(:title, :introduction, :category_id)
  end

end
