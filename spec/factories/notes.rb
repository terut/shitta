# coding: utf-8
FactoryGirl.define do
  factory :note do
    user
    title "aaa"
    raw_body "# h1ダグです\n# h2タグです"
  end
end
