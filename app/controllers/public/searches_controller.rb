class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!


  def search
    @posts= Post.all.order('id DESC').page(params[:page])
    # all_posts = @posts

    # タグ検索に関する記述
    if params[:category_id]
      @posts = Post.includes(:post_category_relations).where(post_category_relations: {category_id: params[:category_id] }).page(params[:page])
      # all_posts = @posts
      @category = Category.find(params[:category_id])
    end

    # キーワード検索に関する記述
    if @range = params[:range]
      if @range == "Post"
        @posts = Post.looks(params[:word]).page(params[:page])
        # @posts = Post.looks(params[:search], params[:word])
      else
        @posts = Post.looks_by_category(params[:word]).page(params[:page])
        # @posts = Post.looks_by_category(params[:search], params[:word])
      end
      # all_posts = @posts
    end
    @categories = current_end_user.categories.order('created_at DESC')
    # @all_posts_count = all_posts.count
    @end_user = current_end_user
  end


end

