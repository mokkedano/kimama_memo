class Public::CommentsController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    @comment = Comment.new
    # redirect_to post_path(post)
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comment = Comment.new
    # redirect_to post_path(params[:post_id])
  end


  def index
  end



  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
