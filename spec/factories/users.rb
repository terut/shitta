FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "ikari#{n}"}
    sequence(:email) {|n| "ikari#{n}@example.com"}
    password 'ikari'
    password_confirmation 'ikari'
    name { username }
    bio "逃げちゃダメだ"

    trait :with_reset_token do
      reset_token SecureRandom.uuid
      reset_token_expired_at 24.hours.since
    end

    trait :with_connected do
      after(:create) { |user| create(:service, user_id: user.id) }
    end

    factory :connected_user, traits: [ :with_connected ]
    factory :reset_token_user, traits: [ :with_reset_token ]
  end

  factory :specify_user, parent: :user do
    username 'test'
    email 'test@example.com'
    password 'test'
    password_confirmation 'test'

    factory :connected_specify_user, traits: [ :with_connected ]
  end
end
