class Quest < ActiveRecord::Base
  enum activity: [ :steps ]

  def meets_requirement?(activity)
    if activity.steps?
      activity.steps >= activity_amount
    else
      false
    end
  end

  def grant_reward(user)
    score = user.score
    attributes_to_update = {}
    [:stamina, :strength, :mind, :vitality, :agility].each do |reward_category|
      reward_value = send("#{reward_category}_reward")
      if reward_value.present?
        new_value = (score.send(reward_category).to_f * (1.0 + (reward_value.to_f / 100.0))).ceil
        new_value = 100 if new_value > 100
        attributes_to_update[reward_category] = new_value
      end
    end

    puts attributes_to_update.inspect

    score.update_attributes!(attributes_to_update)
  end
end
