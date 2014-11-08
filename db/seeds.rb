# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
quests = [
  { title: 'Take 10,000 steps today', stamina_reward: 6, vitality_reward: 4, activity: 'steps', activity_amount: 10_000 },
  { title: 'Take 5,000 steps today', stamina_reward: 3, vitality_reward: 2, activity: 'steps', activity_amount: 4_000 }
]

quests.each do |quest_data|
  quest = Quest.where(title: quest_data[:title]).first || Quest.new
  quest.update_attributes(quest_data)
  quest.save!
end
