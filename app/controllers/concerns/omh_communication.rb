module OmhCommunication
  extend ActiveSupport::Concern

  private

  def authorization_request(tracker)
    Tracker.authorization_request(tracker, current_user)
  end
end
