class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!


  def create
    @post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    @comment = Comment.new
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comment = Comment.new
  end


  def index
  end




  private
  def comment_params
    params.require(:comment).permit(:comment)
  end


end
