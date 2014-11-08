# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quest do
    title "MyString"
    stamina_reward 1
    strength_reward 1
    mind_reward 1
    vitality_reward 1
    agility_reward 1
    activity "MyString"
    activity_amount 1
  end
end
