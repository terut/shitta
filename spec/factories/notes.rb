# coding: utf-8
require 'digest'
FactoryGirl.define do
  factory :note do
    user
    sequence(:title) { |n| "aaa#{n}" }
    raw_body "# h1ダグです\n# h2タグです"
    trait :with_uuid do
      uuid { Digest::MD5.hexdigest(title) }
    end

    factory :shared_note, traits: [:with_uuid]
  end
end
