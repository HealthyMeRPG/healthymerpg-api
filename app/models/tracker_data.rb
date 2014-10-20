class TrackerData
  include TrackerDataFitbit

  def initialize(tracker, start_date, end_date)
    @tracker = tracker
    @start_date = start_date
    @end_date = end_date
  end

  def steps
    # TODO: add &normalize=true
    endpoint = "#{OmhShimConfig.config[:host]}/data/#{@tracker.tracker}/#{Tracker::ENDPOINTS[:steps][@tracker.tracker.to_sym]}?username=#{@tracker.uuid}&dateStart=#{@start_date.strftime('%Y-%m-%d')}&dateEnd=#{@end_date.strftime('%Y-%m-%d')}"
    response = call_shim_server(endpoint)

    send("parse_#{@tracker.tracker}_steps".to_sym, response)
  end

  private

  def call_shim_server(endpoint)
    response = Typhoeus::Request.new(endpoint).run
    Oj.load(response.body)
  end
end
