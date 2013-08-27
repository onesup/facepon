# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  fb_id      :string(255)
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Participant < ActiveRecord::Base

  validates_presence_of :fb_id
  validates_uniqueness_of :fb_id, :email

end
