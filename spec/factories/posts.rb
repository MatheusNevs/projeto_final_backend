FactoryBot.define do
  factory :post do
    title { "MyString" }
    description { "MyString" }
    user {association(:user)}
  end
end
