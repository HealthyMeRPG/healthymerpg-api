module Api
  module V1
    class DashboardController < ::ApplicationController
      before_action :require_user_session!

      def metrics
        render json: TrackerMetrics.new(current_user.trackers)
      end
    end
  end
end
