class Admin::CommentsController < ApplicationController


  def index
    @end_users = EndUser.all
  end


  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
