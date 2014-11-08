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

    "#{OmhShimConfig.config[:host]}/data/#{@tracker.tracker}/#{Tracker::ENDPOINTS[type][@tracker.tracker.to_sym]}?#{parameters.to_query}"
  end

  def can_normalize?(type)
    false
  end

  def call_shim_server(endpoint)
    response = Typhoeus::Request.new(endpoint).run
    Oj.load(response.body)
  end
end
