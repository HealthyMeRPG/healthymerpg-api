namespace :quests do
  task process_rewards: :environment do
    date = Date.today - 1.day
    quests = Quest.all

    User.all.each do |user|
      next unless user.trackers.authorized.count > 0

      activity = user.activities.where(activity_date: date).first || user.activities.create!(activity_date: date, finalized: false)
      activity.finalize!

      quests.each do |quest|
        if quest.meets_requirement?(activity)
          quest.grant_reward(user)
        end
      end
    end
  end
end
