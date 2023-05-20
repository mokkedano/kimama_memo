class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_end_user, only: [:show, :edit, :update, :withdrawal, :favorites]
  before_action :ensure_guest_end_user, only: [:edit]
  before_action :is_matching_login_end_user, only: [:edit, :update]


  def show
    # @posts = @end_user.posts.where(status: true).order('created_at DESC')
    # @point = @end_user.passive_points.all
    @categories = @end_user.categories.order('created_at DESC').limit(15)
    # @posts_category = @end_user.categories.order('created_at DESC').limit(15)
    @posts = @end_user.posts.order('id DESC').limit(4)
  end


  def edit
  end


  def update
    if @end_user.update(end_user_params)
      redirect_to my_page_path, notice: "プロフィールを更新しました！"
    else
      render :edit
    end
  end


  def unsubscribe
  end


  def withdrawal
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end


  def favorites
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    # @post = Post.find(params[:id])
  end





  private
  def end_user_params
    params.require(:end_user).permit(:nickname, :self_introduction, :profile_image)
  end


  def set_end_user
    @end_user = current_end_user
  end


  def ensure_guest_end_user
    if @end_user.nickname == "guest_end_user"
      redirect_to my_page_path(current_end_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end


  def is_matching_login_end_user
    end_user = current_end_user
    unless end_user.id == current_end_user.id
      redirect_to root_path
    end
  end

end
