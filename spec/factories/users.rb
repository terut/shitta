# coding: utf-8
FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "ikari#{n}"}
    sequence(:email) {|n| "ikari#{n}@example.com"}
    password 'ikari'
    password_confirmation 'ikari'
    name { username }
    bio "逃げちゃダメだ"
  end

  factory :specify_user, parent: :user do
    username 'test'
    email 'test@example.com'
    password 'test'
    password_confirmation 'test'
  end

  factory :connected_user, parent: :user do
    after(:create) { |user| create(:service, user_id: user.id) }
  end
end
