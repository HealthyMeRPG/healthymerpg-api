# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_session do
    user nil
    key "MyString"
    ip "MyString"
    user_agent "MyString"
  end
end
