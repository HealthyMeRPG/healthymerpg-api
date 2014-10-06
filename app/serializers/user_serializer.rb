class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :username, :email, :first_name, :last_name

  has_many :trackers

  def trackers
    object.trackers.authorized
  end
end
