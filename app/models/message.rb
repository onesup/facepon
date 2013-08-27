# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  page_id         :integer
#  fbmsg_id        :string(255)
#  created_time    :datetime
#  read_status     :string(255)
#  sender_id       :integer
#  content         :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Message < ActiveRecord::Base

  belongs_to :page
  belongs_to :conversation
  has_many :attachments
  belongs_to :sender, :class_name => 'Participant'

  validates_uniqueness_of :fbmsg_id
  validates_presence_of :fbmsg_id, :created_time


  def duplicate?(_fbmsg_id)
    self.fbmsg_id == _fbmsg_id
  end

end
