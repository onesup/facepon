# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  message_id        :integer
#  conversation_id   :integer
#  page_id           :integer
#  fbattach_id       :string(255)
#  mime_type         :string(255)
#  name              :string(255)
#  size              :integer
#  image_width       :integer
#  image_height      :integer
#  image_url         :integer
#  image_preview_url :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Attachment < ActiveRecord::Base

  belongs_to :page
  belongs_to :conversation
  belongs_to :message

end
