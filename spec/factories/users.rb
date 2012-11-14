# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    email "MyString"
    password_digest "MyString"
    name "MyString"
    bio "MyText"
  end
end
