# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tracker do
    tracker "MyString"
    uuid "MyString"
    user nil
  end
end
