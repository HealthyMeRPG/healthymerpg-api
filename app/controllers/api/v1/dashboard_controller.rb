module Api
  module V1
    class DashboardController < ::ApplicationController
      before_action :require_user_session!

      def metrics
        date = params[:date]
        current_date = Date.today
        if date.present?
          current_date = Date.parse(date)
        end
        render json: TrackerMetrics.new(current_user.trackers.authorized, current_date, current_date)
      end
    end
  end
end
