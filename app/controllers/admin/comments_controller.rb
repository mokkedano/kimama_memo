class Admin::CommentsController < ApplicationController


  def index
    @end_user = EndUser.find(params[:end_user_id])
  end


  # def comment_all
  # end


  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    comment = Comment.find(params[:id])
    comment.destroy
  end


end
