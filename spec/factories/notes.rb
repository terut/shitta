require 'digest'

FactoryGirl.define do
  factory :note do
    user
    sequence(:title) { |n| "aaa#{n}" }
    raw_body "# h1タグです\n# h2タグです"
    trait :with_uuid do
      uuid { Digest::MD5.hexdigest(title) }
    end

    factory :shared_note, traits: [:with_uuid]
    after(:build) do
      Note.skip_callback(:create, :after, :post_notify)
    end
  end
end

