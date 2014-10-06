class UserSession < ActiveRecord::Base
  include UniqueToken

  belongs_to :user

  # generates a unique token in the `key` field upon being created
  before_create { generate_unique_token(:key) }

  # sets the `accessed_at` field to now upon being created
  before_create { self.accessed_at ||= Time.now }

  ##
  # Returns all User Sessions that have been accessed in the past two weeks
  # and that have not been revoked
  def self.active
    accessed_at_field = UserSession.arel_table[:accessed_at]
    where(accessed_at_field.gteq(2.weeks.ago)).where(revoked_at: nil)
  end

  ##
  # Returns the active User Session object matching the passed in key
  def self.authenticate(key)
    active.where(key: key) if key.present?
  end

  ##
  # Sets the `revoked_at` time to now, which will remove it from the
  # `active` scope
  def revoke!
    update_attributes!({
      revoked_at: Time.now
    })
  end

  ##
  # Updates the `accessed_at` time to now, and stores the IP address
  # and user agent from the request
  def access(request)
    update_attributes({
      accessed_at: Time.now,
      ip:          request.ip,
      user_agent:  request.user_agent
    })
  end
end
