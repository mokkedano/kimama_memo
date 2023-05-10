class Public::EndUsersController < ApplicationController


  def show
    @end_user = current_end_user
  end


  def unsubscribe
  end


  def withdrawal
    @end_user = EndUser.find(params[:id])
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end




  private
  def end_user_params
    params.require(:end_user).permit(:nickname, :self_introduction, :profile_image)
  end

end
