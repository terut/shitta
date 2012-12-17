# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user nil
    title "MyString"
    raw_body "MyString"
  end
end
