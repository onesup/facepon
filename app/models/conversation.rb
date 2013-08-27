# == Schema Information
#
# Table name: conversations
#
#  id            :integer          not null, primary key
#  page_id       :integer
#  fbconv_id     :string(255)
#  updated_time  :datetime
#  link          :string(255)
#  message_count :integer
#  unread_count  :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Conversation < ActiveRecord::Base

  belongs_to :page
  has_many :messages

  validates_uniqueness_of :fbconv_id
  validates_presence_of :fbconv_id, :updated_time


  def duplicate?(_updated_time)
    self.updated_time == _updated_time
  end

end
