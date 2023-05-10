class Public::PostsController < ApplicationController


  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end


  def memo_index
    @categories = Category.all
  end


  def index
    @categories = Category.all
    if params([:category_id])
      @category = @categories.find(params[:category_id])
      all_posts = @category.posts
    else
      all_posts = Post.all
      # all_items = Item.where_genre_active.includes(:genre)
    end
    @posts = all_posts
    # @items = all_items.page(params[:page]).per(12)
    @all_posts_count = all_posts.count
  end


  def show
    @post = Post.find(params[:id])
  end


  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
  end


  def destroy
    @post = Post.find(params[:id])
  end




  private
  def post_params
    params.require(:post).permit(:title, :introduction, :category_id, :image)
  end

end
