# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    password_digest "MyString"
    email "MyString"
    first_name "MyString"
    last_name "MyString"
  end
end
