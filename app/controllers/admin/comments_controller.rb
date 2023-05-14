class Admin::CommentsController < ApplicationController


  def index
    @end_users = EndUser.all
  end


  def destroy
    @post = Post.find(params[:end_user_id])
    comment = Comment.find(params[:id])
    comment.destroy
  end


  private
  # def comment_params
  #   params.require(:comment).permit(:comment)
  # end
end
