FactoryBot.define do
  factory :user do
    name {'teste'}
    last_name {'testee'}
    email {'teste@gmail.com'}
    password {'123456'}
    description {'testetestetestetestetestetestetesteteste'}
    is_admin {false}
  end
end
