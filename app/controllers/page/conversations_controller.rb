class Page::ConversationsController < ApplicationController

  before_action :find_page

  def index
    @conversations = @page.conversations
  end

  def fetch_from_fb
    require "fb_tools"
    cp = FBTools::ConversationParser.new(@page)
    cp.fetch_and_parse_and_store

    render :js => "alert('Success!!');"
  end

  protected

    def find_page
      @page = Page.find(params[:page_id])
    end

end
