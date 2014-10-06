require 'omh_shim_config'

class Tracker < ActiveRecord::Base
  include UniqueToken

  # generates a unique token in the `uuid` field upon being created
  before_create { generate_uuid(:uuid) }

  belongs_to :user

  scope :active, -> { where(active: true) }

  enum tracker: [ :fitbit, :healthvault, :jawbone, :runkeeper, :withings, :fatsecret ]

  def self.authorization_request(tracker_type, user)
    tracker = Tracker.create!(user: user, tracker: Tracker.trackers[tracker_type], active: true)
    tracker.authorize_url
  end

  def authorize_url
    # make the response to the Open mHealth Shim server
    response = Typhoeus::Request.new("#{OmhShimConfig.config[:host]}/authorize/#{tracker}?username=#{uuid}").run
    response_hash = Oj.load(response.body)

    # save the state key inside the tracker
    update_attribute(:omh_shim_id, response_hash['stateKey'])

    # return the authorization url
    response_hash['authorizationUrl']
  end

  def authorize!(params)
    # make the response to the Open mHealth Shim server
    response = Typhoeus::Request.new("#{OmhShimConfig.config[:host]}/authorize/#{tracker}/callback?#{params.to_query}").run
    response_hash = Oj.load(response.body)

    raise "Failed to register tracker #{self}: #{response_hash.inspect}" if response_hash['type'] != 'AUTHORIZED'
  end
end
