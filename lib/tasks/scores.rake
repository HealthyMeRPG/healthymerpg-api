namespace :db do
  desc 'Seeds scores for existing users'
  task seed_scores: :environment do
    users_table = User.arel_table
    users = User.where(users_table[:id].not_in(Score.pluck(:user_id)))
    users.each do |user|
      user.create_score(stamina: 90, strength: 90, mind: 90, vitality: 90, agility: 90)
    end
  end

  desc 'Decrements scores'
  task decrement_scores: :environment do
    scores = Score.all
    scores.each do |score|
      score.decrement_attributes
    end
  end
end
