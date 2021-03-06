class Score < ActiveRecord::Base

  belongs_to :user

  scope :for_user, ->(user) { where(user: user) }

  def decrement_attributes(decrement_value = 2)
    attrs = [:stamina, :strength, :mind, :vitality, :agility]
    attrs.each do |attr|
      value = send(attr)
      value -= decrement_value
      value = 0 if value < 0
      send("#{attr}=", value)
    end
    save
  end

end
