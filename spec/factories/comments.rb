# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    note nil
    user nil
    raw_body "MyText"
  end
end
