FactoryGirl.define do
  factory :comment do
    note
    user
    raw_body "# comment test"
  end
end
