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
        authorized_trackers = current_user.trackers.authorized

        response = Rails.cache.fetch("#{current_user.id}_metrics_#{authorized_trackers.count}_#{current_date.strftime('%Y-%m-%d')}", expires_in: 1.hour) do
          TrackerMetrics.new(authorized_trackers, current_date, current_date).to_json
        end

        render json: response
      end
    end
  end
end
