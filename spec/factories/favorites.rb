# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite do
    association :user, factory: :user
    association :note, factory: :note
    point 1
  end
end
