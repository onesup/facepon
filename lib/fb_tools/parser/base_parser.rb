module FBTools
  class BaseParser


    protected

      def create_new_participants(fb_partis = [])
        fb_partis.each do |fb_parti|
          participant = find_or_create_participant(fb_parti)
        end
      end

      def map_paging_params(url)
        params = {}
        URI(url).query.split('&').each do |q|
          _qs = q.split('=')
          if ['limit', 'until'].include?(_qs[0])
            params.store( _qs[0], _qs[1] )
          end
        end
        return params
      end

      def find_or_create_participant(fb_parti)
        unless participant = Participant.find_by_fb_id(fb_parti['id'])
          participant = Participant.create(
            fb_id: fb_parti['id'],
            name: fb_parti['name'],
            email: fb_parti['email']
          )
        end

        return participant
      end

      def limitation
        50
      end

      def merge_params!(params)
        params.merge!({ 'limit' => limitation })
      end

  end
end
