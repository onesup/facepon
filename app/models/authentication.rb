# == Schema Information
#
# Table name: authentications
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  access_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Authentication < ActiveRecord::Base

  belongs_to :user

  def self.create_or_update_token!(_user, auth)
    authentication = _user.authentication

    unless authentication
      Authentication.create!(
        :user_id => _user.id,
        :access_token => auth[:credentials][:token]
      )
    else
      authentication.update_attribute(:access_token, auth[:credentials][:token])
    end
  end



end
