FactoryBot.define do
  factory :feedback do
    like { false }
    comment { "MyString" }
    user {association(:user)}
    post {association(:post)}
  end
end
