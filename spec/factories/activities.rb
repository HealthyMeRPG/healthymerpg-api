# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user nil
    activity_date "2014-11-10"
    steps 1
    calories_burned 1
    floors 1
    very_active_minutes 1
  end
end
