class ActivitySerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :activity_date, :steps, :calories_burned, :floors_climbed, :very_active_minutes, :finalized

  has_one :user
end
