module FBTools
  class ConversationParser < BaseParser

    def initialize(page)
      @page = page
      @graph = Koala::Facebook::API.new(page.access_token)
    end

    def fetch_and_parse_and_store(once = false, params = {})
      merge_params!(params)
      puts "  #Conversation - fetch and parse: #{params.to_s}"
      res = fetch(params)

      unless res.empty?
        parse_and_store(res)

        unless once
          paging_params = map_paging_params(res.paging['next'])
          fetch_and_parse_and_store(once, paging_params)
        end
      end
    end

    def fetch(params = {})
      query_string = params.map{ |r| r.join('=') }.join('&')
      unless query_string.empty?
        query_string = "?#{query_string}"
      end

      @graph.get_connection(@page.page_id, "conversations#{query_string}")
    end

    def parse_and_store(fb_convs = [])
      fb_convs.each do |fb_conv|

        unless conversation = @page.conversations.find_by_fbconv_id(fb_conv['id'])
          conversation = @page.conversations.new(
            fbconv_id: fb_conv['id'],
            link: fb_conv['link']
          )
        end
        conversation.updated_time = fb_conv['updated_time']
        conversation.message_count = fb_conv['message_count']
        conversation.unread_count = fb_conv['unread_count']

        if conversation.save
          # create paricipants from senders exclude page_id
          create_new_participants(fb_conv['senders']['data'])

          # insert messages
          _mp = MessageParser.new(@graph, conversation)
          _mp.parse_and_store(fb_conv['messages']['data'])
          _mp.fetch_and_parse_and_store(false, map_paging_params(fb_conv['messages']['paging']['next']))
        end
      end
    end


  end
end
