require 'digest'

FactoryGirl.define do
  factory :note do
    user
    sequence(:title) { |n| "aaa#{n}" }
    raw_body "# h1タグです\n# h2タグです"

    trait :with_uuid do
      uuid { Digest::MD5.hexdigest(title) }
    end

    transient do
      tags_count 0
    end

    factory :shared_note, traits: [:with_uuid]
    factory :build_note_with_tags, traits: [:build_with_tags]

    after(:build) do
      Note.skip_callback(:create, :after, :post_notify)
    end

    factory :note_with_tags do
      after(:build) do |note, evaluator|
        Note.skip_callback(:create, :after, :post_notify)
        note.tags << build_list(:tag, evaluator.tags_count)
      end
    end
  end
end

