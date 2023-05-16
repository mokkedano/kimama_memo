class Public::ChatMessagesController < ApplicationController


  def index
    @group = Group.find(params[:group_id])
  end


  def create
    @messages = ChatMessage.new(message_params)
    if @messages.save
      redirect_to group_chat_messages_path(@group), notice: "メッセージを送信しました！"
    else
      render :index
    end
  end


  def destroy
  end



  private
  def message_params
    params.require(:chat_message).permit(:message, :group_id)
  end


end
