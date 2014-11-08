class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :username, :email, :first_name, :last_name

  has_many :trackers
  has_one :score

  def trackers
    object.trackers.authorized
  end
end
