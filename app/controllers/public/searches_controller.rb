class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!


  def search
    @range = params[:range]
    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
      # search_posts = @posts★
    else
      # @categories = Category.looks(params[:search], params[:word])
      @posts = Category.looks(params[:search], params[:word])
      # @posts = @categories
      # search_category_posts = @categories.post.id★
    end
    # @all_posts_count = search_posts.count★
    # @all_categories_posts_count = search_category_posts.count★
    # ★コメントアウトにしている部分は、検索件数を出そうとした記述。エラーになったため、一旦おいとく。


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



  @posts= Post.all
  @categories = Category.all
  @posts = @posts.where("title LIKE(?) or introduction LIKE(?)", "%#{params[:word]}%","%#{params[:word]}%") if params[:word].present?
  #もしタグ検索したら、post_idsにタグを持ったidをまとめてそのidで検索
  if params[:category_ids].present?
    post_ids = []
    params[:category_ids].each do |key, value|
      if value == "1"
        Category.find_by(name: key).posts.each do |p|
          post_ids << p.id
        end
      end
    end
    post_ids = post_ids.uniq
    #キーワードとタグのAND検索
    @posts = @posts.where(id: post_ids) if post_ids.present?
  end
end


end
