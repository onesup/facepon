# == Schema Information
#
# Table name: pages
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  page_id              :string(255)
#  name                 :string(255)
#  link                 :string(255)
#  category             :string(255)
#  about                :string(255)
#  desc                 :string(255)
#  desc_html            :string(255)
#  picture              :string(255)
#  likes                :integer
#  unread_message_count :integer
#  unread_notif_count   :integer
#  unseen_message_count :integer
#  access_token         :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class Page < ActiveRecord::Base

  validates_presence_of :page_id, :name

  belongs_to :user
  has_many :conversations


  private
    before_create :fetch_and_set_attrs_from_fb

    def fetch_and_set_attrs_from_fb
      graph = Koala::Facebook::API.new(user.authentication.access_token)
      @fbpage = graph.get_object("#{self.page_id}?fields=id,access_token,link,likes,picture.type(normal),unread_message_count,unread_notif_count,unseen_message_count,about,description,description_html")

      self.access_token = @fbpage['access_token']
      self.link = @fbpage['link']
      self.about = @fbpage['about']

      self.desc = @fbpage['desc']
      self.desc_html = @fbpage['desc_html']
      self.picture = @fbpage['picture']['data']['url']

      self.likes = @fbpage['likes'] || 0
      self.unread_message_count = @fbpage['unread_message_count'] || 0
      self.unread_notif_count = @fbpage['unread_notif_count'] || 0
      self.unseen_message_count = @fbpage['unseen_message_count'] || 0
    end

end
