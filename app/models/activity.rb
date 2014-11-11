class Activity < ActiveRecord::Base
  belongs_to :user

  scope :finalized, -> { where(finalized: true) }

  def outdated?
    !finalized? && updated_at < 1.hour.ago
  end

  def update_activity!
    metrics = TrackerMetrics.new(user.trackers.authorized, activity_date)
    activity = metrics.activity

    update_attributes!({
      steps: metrics.steps,
      calories_burned: activity[:calories_burned],
      floors_climbed: activity[:floors],
      very_active_minutes: activity[:very_active_minutes],
      updated_at: Time.now
    })

    update_attributes!(finalized: true) if activity_date < Date.today
  end

  def finalize!
    update_activity!
    update_attributes!(finalized: true)
  end
end
