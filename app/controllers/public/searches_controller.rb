class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!


  def search
    @posts= Post.all
    all_posts = @posts

    # タグ検索に関する記述
    if params[:category_id]
      @posts = Post.includes(:post_category_relations).where(post_category_relations: {category_id: params[:category_id] })
      all_posts = @posts
      @category = Category.find(params[:category_id])
      #@category_name = @posts
    end

    # キーワード検索に関する記述
    if @range = params[:range]
      if @range == "Post"
        @posts = Post.looks(params[:word])
        # @posts = Post.looks(params[:search], params[:word])
      else
        @posts = Post.looks_by_category(params[:word])
        # @posts = Post.looks_by_category(params[:search], params[:word])
      end
      all_posts = @posts
    end
    @categories = current_end_user.categories.order('created_at DESC')
    @all_posts_count = all_posts.count


  end

end





    # キーワード検索とカテゴリ検索を両立させたくて記述したコード
    # @posts= Post.all
    # @categories = current_end_user.categories
    # @posts = @posts.where("title LIKE(?) or introduction LIKE(?)", "%#{params[:word]}%","%#{params[:word]}%") if params[:word].present?
    # #もしカテゴリ検索したら、post_idsにカテゴリを持ったidをまとめてそのidで検索
    # if params[:category_ids].present?
    #   post_ids = []
    #   params[:category_ids].each do |key, value|
    #     if value == "1"
    #       Category.find_by(name: key).posts.each do |p|
    #         post_ids << p.id
    #       end
    #     end
    #   end
    #   post_ids = post_ids.uniq
    #   #キーワードとカテゴリのAND検索
    #   @posts = @posts.where(id: post_ids) if post_ids.present?
    # end



 #   @posts = Post.all
  #   if params[:category_ids]
  #     @posts = []
  #     params[:category_ids].each do |key, value|
  #       if value == "1"
  #         category_posts = Category.find_by(name: key).posts
  #         @posts = @posts.empty? ? category_posts : @posts & category_posts
  #       end
  #     end
  #   end
  # end



