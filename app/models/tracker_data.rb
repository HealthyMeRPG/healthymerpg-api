require 'typhoeus/adapters/faraday'

class TrackerData
  include TrackerDataFitbit
  include TrackerDataJawbone

  def initialize(tracker, start_date, end_date)
    @tracker = tracker
    @start_date = start_date
    @end_date = end_date
  end

  def steps
    endpoint = url_for(:steps)
    response = call_shim_server(endpoint)

    send("parse_#{@tracker.tracker}_steps".to_sym, response)
  end

  def activity
    endpoint = url_for(:activity)
    response = call_shim_server(endpoint)

    send("parse_#{@tracker.tracker}_activity".to_sym, response)
  end

  private

  def url_for(type)
    parameters = {
      username: @tracker.uuid,
      dateStart: @start_date.strftime('%Y-%m-%d'),
      dateEnd: @end_date.strftime('%Y-%m-%d')
    }

    if can_normalize?(type)
      parameters[:normalize] = 'true'
    end

    "/data/#{@tracker.tracker}/#{Tracker::ENDPOINTS[type][@tracker.tracker.to_sym]}?#{parameters.to_query}"
  end

  def can_normalize?(type)
    false
  end

  def omh_shim_conn
    @omh_shim_conn ||= Faraday.new(OmhShimConfig.config[:host]) do |faraday|
      faraday.response :logger
      faraday.adapter :typhoeus
    end
  end

  def call_shim_server(endpoint)
    response = omh_shim_conn.get(endpoint)
    Oj.load(response.body)
  end
end
