# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
quests = [
  { title: 'Take 10,000 steps today', stamina_reward: 6, vitality_reward: 4, activity: 'steps', activity_amount: 10_000 },
  { title: 'Take 5,000 steps today', stamina_reward: 3, vitality_reward: 2, activity: 'steps', activity_amount: 5_000 },
  { title: 'Climb 10 floors today', strength_reward: 3, agility_reward: 2, activity: 'floors_climbed', activity_amount: 10 },
  { title: 'Climb 20 floors today', strength_reward: 6, agility_reward: 4, activity: 'floors_climbed', activity_amount: 20 },
  { title: 'Burn 2000 calories today', stamina_reward: 3, vitality_reward: 3, activity: 'calories_burned', activity_amount: 2000 },
  { title: 'Burn 3000 calories today', stamina_reward: 6, vitality_reward: 6, activity: 'calories_burned', activity_amount: 3000 },
  { title: 'Obtain 30 very active minutes today', stamina_reward: 3, agility_reward: 2, activity: 'very_active_minutes', activity_amount: 30 },
  { title: 'Obtain 60 very active minutes today', stamina_reward: 6, agility_reward: 4, activity: 'very_active_minutes', activity_amount: 60 }
]

quests.each do |quest_data|
  quest = Quest.where(title: quest_data[:title]).first || Quest.new
  quest.update_attributes(quest_data)
  quest.save!
end
