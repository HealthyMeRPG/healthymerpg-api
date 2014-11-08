class TrackerMetrics
  def initialize(trackers, start_date, end_date)
    @trackers = trackers
    @start_date = start_date
    @end_date = end_date
  end

  def steps
    @trackers.reduce(0) { |memo, tracker| memo + tracker.steps(@start_date, @end_date) }
  end

  def activity
    @trackers.reduce({}) do |memo, tracker|
      memo.merge(tracker.activity(@start_date, @end_date)) do |key, old_value, new_value|
        (old_value || 0) + new_value
      end
    end
  end

  def to_json(*args)
    {
      steps: steps,
      activity: activity
    }.to_json
  end
end
