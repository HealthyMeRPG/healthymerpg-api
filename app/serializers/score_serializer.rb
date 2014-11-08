class ScoreSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :stamina, :strength, :mind, :vitality, :agility

  has_one :user
end
