class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!


  def index
    @end_user = EndUser.find(params[:end_user_id])
  end


  def comment_all
    @comments = Comment.all
    # @comments = Comment.where(comment: @comment)
    # @end_user = Comment.find(params[:post_id])
  end


  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    comment = Comment.find(params[:id])
    comment.destroy
    @post = comment.post
    # @comments = Comment.find(params[:id])
  end


end
