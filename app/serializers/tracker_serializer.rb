class TrackerSerializer < ActiveModel::Serializer
  attributes :id, :tracker, :uuid

  belongs_to :user
end
