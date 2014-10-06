class TrackerSerializer < ActiveModel::Serializer
  attributes :id, :tracker, :uuid

  has_one :user
end
