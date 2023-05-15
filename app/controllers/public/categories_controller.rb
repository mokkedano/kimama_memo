class Public::CategoriesController < ApplicationController
  before_action :authenticate_end_user!
  # before_action :is_matching_login_end_user, only: [:edit, :update]


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


  # def is_matching_login_end_user
  #   category = Category.find(params[:id])
  #   unless end_user.id == current_end_user.id
  #     redirect_to root_path
  #   end
  # end

end
