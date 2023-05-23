class Public::ChatMessagesController < ApplicationController
  before_action :authenticate_end_user!


  def index
    @group = Group.find(params[:group_id])
    @message = ChatMessage.new
    @messages = ChatMessage.where(group: @group).limit(30)
    @end_user = current_end_user
  end


  def create
    @group = Group.find(params[:group_id])
    @message = ChatMessage.new(message_params)
    if @message.save
      redirect_to group_chat_messages_path(@group), notice: "メッセージを送信しました！"
    else
      render :index
    end
  end


  def destroy
    @group = Group.find(params[:group_id])
    @messages = ChatMessage.find(params[:id])
    if @messages.destroy
      redirect_to group_chat_messages_path(@group), notice: "メッセージを削除しました。"
    end
  end



  private
  def message_params
    params.require(:chat_message).permit(:message, :group_id).merge(end_user_id: current_end_user.id)
  end


end
