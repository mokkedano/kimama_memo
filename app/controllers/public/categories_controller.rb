class Public::CategoriesController < ApplicationController
  before_action :authenticate_end_user!


  def index
    @category = Category.new
    @categories = current_end_user.categories
  end


  def create
    # @category = Category.new(category_params)
    # if @category.save
    #   redirect_to categories_path
    # else
    #   @categories = current_end_user.categories
    #   render :index
    # end
  end


  def edit
    @category = Category.find(params[:id])
  end


  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end




  private
  def category_params
    params.require(:category).permit(:name)
  end


end
