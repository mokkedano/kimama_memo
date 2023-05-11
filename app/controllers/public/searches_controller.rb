class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!


  def search
    @range = params[:range]
    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
      # search_posts = @posts★
    else
      @categories = Category.looks(params[:search], params[:word])
      # search_category_posts = @categories.post.id★
    end
    # @all_posts_count = search_posts.count★
    # @all_categories_posts_count = search_category_posts.count★
    # ★コメントアウトにしている部分は、検索件数を出そうとした記述。エラーになったため、一旦おいとく。
  end
  
  

end
