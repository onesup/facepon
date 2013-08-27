# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  provider      :string(255)
#  uid           :string(255)
#  name          :string(255)
#  email         :string(255)
#  profile_image :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base

  has_one :authentication
  has_many :pages

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
      user.profile_image = auth['info']['image']
    end
  end



end
