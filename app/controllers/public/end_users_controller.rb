class Public::EndUsersController < ApplicationController


  def show
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

end
