class Quest < ActiveRecord::Base
  enum activity: [ :steps, :floors_climbed, :calories_burned, :very_active_minutes ]

  # returns true if the requirements for the quest reward were met and false if not
  def meets_requirement?(activity)
    if activity.steps?
      activity.steps >= activity_amount
    else
      false
    end
  end

  # grants reward to user based on reward category and value
  def grant_reward(user)
    score = user.score  # get user score
    # for each category, get the value, if not nil, calculate new value for category
    attributes_to_update = {}
    [:stamina, :strength, :mind, :vitality, :agility].each do |reward_category|
      reward_value = send("#{reward_category}_reward")
      if reward_value.present?
        # new_value = (score.send(reward_category).to_f * (1.0 + (reward_value.to_f / 100.0))).ceil
        new_value = score.send(reward_category).to_i + reward_value.to_i
        new_value = 100 if new_value > 100      # 100% max
        attributes_to_update[reward_category] = new_value
      end
    end
    score.update_attributes!(attributes_to_update)
  end
end
