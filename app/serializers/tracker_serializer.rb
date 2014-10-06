class TrackerSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :tracker, :uuid

  has_one :user
end
