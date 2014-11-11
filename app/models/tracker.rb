require 'omh_shim_config'

class Tracker < ActiveRecord::Base
  include UniqueToken

  # generates a unique token in the `uuid` field upon being created
  before_create { generate_uuid(:uuid) }

  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :authorized, -> { where(authorized: true) }

  enum tracker: [ :fitbit, :healthvault, :jawbone, :runkeeper, :withings, :fatsecret ]

  ENDPOINTS = {
    steps: {
      fitbit: 'steps',
      jawbone: 'moves',
      withings: 'intraday'
    },
    activity: {
      fitbit: 'activity',
      jawbone: 'workouts'
    }
  }

  def self.authorization_request(tracker_type, user)
    tracker = Tracker.create!(user: user, tracker: Tracker.trackers[tracker_type], active: true, authorized: false)
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

    update_attribute(:authorized, true)
  end

  def deauthorize!
    # make the response to the Open mHealth Shim server
    response = Typhoeus::Request.new("#{OmhShimConfig.config[:host]}/de-authorize/#{tracker}?username=#{uuid}", { method: :delete }).run
    response_array = Oj.load(response.body)

    fail 'Unable to unregister tracker' unless response_array.try(:[], 0) == 'Success: Authorization Removed.'

    # set the tracker to no longer be active or authorized, and wipe the Open mHealth shim ID
    update_attributes(authorized: false, active: false, omh_shim_id: nil)
  end

  def steps(activity_date)
    return 0 if [:healthvault, :runkeeper].include?(tracker)

    data = TrackerData.new(self, activity_date).steps
  end

  def activity(activity_date)
    # TODO
    return nil if [:withings].include?(tracker)

    data = TrackerData.new(self, activity_date).activity
  end
end
