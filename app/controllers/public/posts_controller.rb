class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :is_matching_login_end_user, only: [:edit, :update, :destroy]


  def new
    @post = Post.new
    @categories = current_end_user.categories
  end


  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    category_list = params[:post][:name].split(',')
    if @post.save
      @post.save_category(category_list)
      redirect_to post_path(@post), notice: "メモを保存しました！"
    else
      render :new
    end
  end


  def index
    # @posts = Post.page(params[:page]).per(10)
    @posts = current_end_user.posts
    @categories = current_end_user.categories

    # @categories = Category.all
    # if params[:category_id]
    #   @category = @categories.find(params[:category_id])
    #   all_posts = @category.posts
    # else
    #   all_posts = Post.all
    #   # all_items = Item.where_genre_active.includes(:genre)
    # end
    # @posts = all_posts
    # # @items = all_items.page(params[:page]).per(12)
    # @all_posts_count = all_posts.count
  end


  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @categories = @post.categories
  end


  def edit
    @post = Post.find(params[:id])
    @category_list = @post.categories.pluck(:name).join(',')
    @categories = current_end_user.categories
  end


  def update
    @post = Post.find(params[:id])
    category_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @old_relations = PostCategoryRelation.where(post_id: @post.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @post.save_category(category_list)
      redirect_to post_path(@post), notice: "メモを更新しました！"
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "メモを削除しました。"
  end


  def search_category
    @categories = current_end_user.categories
    @category = @categories.find(params[:category_id])
    # @posts = @category.posts.page(params[:page]).per(10)
    @posts = @category.posts
  end




  private
  def post_params
    params.require(:post).permit(:title, :introduction, :image)
    # params.require(:post).permit(:title, :introduction, :image, category_ids: [])
  end


  def is_matchig_login_end_user
    post = Post.find(params[:id])
    unless post.end_user.id == current_end_user.id
      redirect_to root_path
    end
  end


end
