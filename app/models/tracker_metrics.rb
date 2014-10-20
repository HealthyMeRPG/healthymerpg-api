class TrackerMetrics
  def initialize(trackers)
    @trackers = trackers
    @start_date = Date.today
    @end_date = Date.today
  end

  def steps
    @trackers.reduce(0) { |memo, tracker| memo + tracker.steps(@start_date, @end_date) }
  end

  def to_json(*args)
    {
      steps: steps
    }.to_json
  end
end
