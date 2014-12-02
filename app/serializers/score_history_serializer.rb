class ScoreHistorySerializer < ActiveModel::Serializer
  attributes :id, :date, :score

  def id
    SecureRandom.uuid
  end
end
