require Rails.root.join('app', 'validators', 'email_validator')

class User < ActiveRecord::Base
  # creates the password, password_confirmation, password_digest fields
  # on the model, and handles encrypting the password upon updating
  has_secure_password

  # store only the lower cased email
  before_create { self.email = self.email.try(:downcase) }

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { in: 6..64 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  # relationships
  has_many :user_sessions, -> { active }
  has_many :trackers, -> { active }

  ##
  # Finds a user with the given email address, and runs the `authenticate`
  # method on that user with the given password. The `authenticate` method
  # comes from `has_secure_password`, and will return the User model
  # if the password matches the encrypted one, or nil otherwise
  def self.authenticate(email_address, password)
    where(email: email_address.try(:downcase)).first.try(:authenticate, password)
  end
end
