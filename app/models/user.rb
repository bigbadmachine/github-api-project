# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  uid              :integer
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  auth_token       :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class User < ActiveRecord::Base

	validates_presence_of :name, :uid

	before_save { generate_token(:auth_token) }

	def self.update_or_create_with_omniauth(auth_hash)
		if (user = User.where(uid: auth_hash.info.uid).first rescue nil)
			user.oauth_token = auth_hash.credentials.token
			user.oauth_expires_at = (Time.at(auth_hash.credentials.expires_at) rescue nil)
		else
	    user = User.new( name: auth_hash.info.name,
	    									email: auth_hash.info.email,
	                      oauth_token: auth_hash.credentials.token,
	                      oauth_expires_at: (Time.at(auth_hash.credentials.expires_at) rescue nil),
	                      uid: auth_hash.uid )
	  end
	  user.save
    user
  end

  private
  	def generate_token(column)
	    if User.exists?(column => self[column]) && self[column].nil?
	      self[column] = SecureRandom.urlsafe_base64
	    end
	  end
end
