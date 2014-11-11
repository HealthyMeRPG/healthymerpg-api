class TrackerMetrics
  def initialize(trackers, activity_date)
    @trackers = trackers
    @activity_date = activity_date
  end

  def steps
    @steps ||= @trackers.map { |tracker| tracker.steps(@activity_date) }.max
  end

  def activity
    @activity ||= @trackers.reduce({}) do |memo, tracker|
      memo.merge(tracker.activity(@activity_date)) do |key, old_value, new_value|
        [old_value || 0, new_value].max
      end
    end
  end
end
