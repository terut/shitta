# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user
    title "aaa"
    raw_body "# h1ダグです\n# h2タグです"
  end
end
