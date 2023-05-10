# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :end_user_state, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end



  def after_sign_in_path_for(resource)
    mypage_path
  end


  def after_sign_out_path_for(resource)
    root_path
  end



  # 退会している会員かどうかを判断するためのメソッド
  def end_user_state
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && !@end_user.is_deleted
        flash[:notice] = "退会済みのようです。申し訳ございませんが、別のメールアドレスを使い再度ご登録ください。"
        redirect_to new_end_user_registration_path
      end
    end
  end

end
