require 'digest'
FactoryGirl.define do
  factory :service do
    sequence(:username) { |n| "test#{n}" }
    token { Digest::MD5.hexdigest(username) }
    user_id 1
  end
end
