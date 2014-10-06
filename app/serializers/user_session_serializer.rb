class UserSessionSerializer < ActiveModel::Serializer
  self.root = false

  attributes :user_token, :user_email

  def user_token
    object.key
  end

  def user_email
    object.user.email
  end
end
