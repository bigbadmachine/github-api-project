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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "User Name"
    uid 1
  end
end
