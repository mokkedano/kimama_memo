class Admin::CommentsController < ApplicationController


  def index
    @end_user = EndUser.find(params[:end_user_id])

  end


  def destroy
    @post = Post.find(params[:end_user_id])
    comment = Comment.find(params[:id])
    comment.destroy
  end


end
