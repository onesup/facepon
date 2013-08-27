module FBTools
  class MessageParser < BaseParser

    def initialize(graph, conversation)
      @conversation = conversation
      @page = conversation.page
      @graph = graph
    end

    def fetch_and_parse_and_store(once = false, params = {})
      merge_params!(params)
      puts "  #Message - fetch and parse: #{params.to_s}"
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

      @graph.get_connection(@conversation.fbconv_id, "messages#{query_string}")
    end


    def parse_and_store(fb_msgs)
      fb_msgs.each do |fb_msg|
        unless msg = @conversation.messages.find_by_fbmsg_id(fb_msg['id'])
          msg = @conversation.messages.new(
            page_id: @page.id,
            fbmsg_id: fb_msg['id'],
            created_time: fb_msg['created_time'],
            read_status: distinguish_read_status(fb_msg['tags']['data']),
            sender: find_or_create_participant(fb_msg['from']),
            content: fb_msg['message']
          )
          msg.save

          # store attachments
          if fb_msg.keys.include?('attachments')
            parse_and_store_attachments(msg, fb_msg['attachments']['data'])
          end
        end
      end
    end



    private

      def parse_and_store_attachments(msg, fb_attachments)
        fb_attachments.each do |fb_atta|
          attachment = msg.attachments.new(
            page_id: msg.page_id,
            conversation_id: msg.conversation.id,
            fbattach_id: fb_atta['id'],
            mime_type: fb_atta['mime_type'],
            name: fb_atta['name'],
            size: fb_atta['size'].to_i
          )

          if fb_atta.keys.include?('image_data')
            attachment.image_width = fb_atta['image_data']['width']
            attachment.image_height = fb_atta['image_data']['height']
            attachment.image_url = fb_atta['image_data']['url']
            attachment.image_preview_url = fb_atta['image_data']['preview_url']
          end

          attachment.save
        end
      end

      def distinguish_read_status(tags = [])
        read_status = nil
        tags.each do |tag|
          if tag['name'] == 'read'
            read_status = 'read'
            break
          end
        end
        return read_status
      end


  end
end
