class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

end
