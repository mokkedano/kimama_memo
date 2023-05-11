class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!


  def search
    @range = params[:range]
    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    else
      @categories = Category.looks(params[:search], params[:word])
    end
  end


end
