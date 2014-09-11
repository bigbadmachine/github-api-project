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

require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }

  context '.name' do
    it 'cannot be nil' do
    	user.name = nil
      user.save
      expect(user).to_not be_valid
    end
  end

  context '.uid' do
    it 'cannot be nil' do
      user.uid = nil
      user.save
      expect(user).to_not be_valid
    end
  end

  context '.auth_token' do
  	it 'should be created on_create' do
  		expect(FactoryGirl.create(:user).auth_token).to_not be_nil
    end

    it 'should be created on_save' do
      user.auth_token = nil
      user.save!
      expect(user.auth_token).to_not be_nil
    end
  end

  context '.update_or_create_with_omniauth' do
  	auth_hash = FactoryGirl.create(:github_auth, uid: 12345)
  	it 'should create a new user' do
  		expect(User.count).to eq 1
  		subject.class.update_or_create_with_omniauth(auth_hash)
  		expect(User.count).to eq 2
  		subject.class.update_or_create_with_omniauth(auth_hash)
  		expect(User.count).to eq 2
  	end

  end

end
