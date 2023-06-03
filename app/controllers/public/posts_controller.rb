class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_end_user, only: [:new, :create, :index, :show, :edit, :update, :search_category]
  # before_action :is_matching_login_end_user, only: [:edit, :update, :destroy]


  def new
    @post = Post.new
    @categories = current_end_user.categories.order('created_at DESC')
    # @category_options = Vision.get_image_data(post_params[:image])
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
    @posts = current_end_user.posts.page(params[:page])
    @categories = current_end_user.categories.order('created_at DESC')

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
    @comment = Comment.new
    @categories = @post.categories
  end


  def edit
    @category_list = @post.categories.pluck(:name).join(',')
    @categories = current_end_user.categories.order('created_at DESC')
  end


  def update
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
    @post.destroy
    redirect_to posts_path, notice: "メモを削除しました。"
  end


  def search_category
    @categories = current_end_user.categories.order('created_at DESC')
    @category = Category.find(params[:category_id])
    @posts = current_end_user.posts.includes(:post_category_relations).where(post_category_relations: {category_id: params[:category_id] }).page(params[:page])
  end


  def category_options
    # @post = Post.new(post_params)

    # @category_options = Vision.get_image_data(post_params[:image])

      # category_options.each do |option|
      #   @post.option
      # end
  end




  private
  def post_params
    params.require(:post).permit(:title, :introduction, :image)
  end


  def set_post
    @post = Post.find(params[:id])
  end


  def set_end_user
    @end_user = current_end_user
  end


  # def is_matchig_login_end_user
  #   post = Post.find(params[:id])
  #   unless post.end_user.id == current_end_user.id
  #     redirect_to root_path
  #   end
  # end


end
