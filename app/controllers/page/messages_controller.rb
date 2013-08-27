class Page::MessagesController < ApplicationController

  before_action :find_page_and_conversation

  def index
    @messages = @conversation.messages
  end


  protected

    def find_page_and_conversation
      @page = Page.find(params[:page_id])
      @conversation = @page.conversations.find(params[:conversation_id])
    end

end
