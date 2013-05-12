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
end
