class Public::ChatMessagesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_group, only: [:index, :create, :destroy]
  before_action :set_end_user, only: [:index, :create]


  def index
    @message = ChatMessage.new
    @messages = ChatMessage.where(group_id: @group.id).order('id DESC').page(params[:page]).per(10)
  end


  def create
    @message = ChatMessage.new(message_params)
    @messages = ChatMessage.where(group_id: @group.id).order('id DESC').page(params[:page]).per(10)
    if @message.save
      redirect_to group_chat_messages_path(@group), notice: "メッセージを送信しました！"
    else
      render :index
    end
  end


  def destroy
    @messages = ChatMessage.find(params[:id])
    if @messages.destroy
      redirect_to group_chat_messages_path(@group), notice: "メッセージを削除しました。"
    end
  end




  private
  def message_params
    params.require(:chat_message).permit(:message, :group_id).merge(end_user_id: current_end_user.id)
  end


  def set_group
    @group = Group.find(params[:group_id])
  end


  def set_end_user
    @end_user = current_end_user
  end


end
