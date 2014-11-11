module Api
  module V1
    class ActivitiesController < ::ApplicationController
      before_action :require_user_session!

      def index
        activity_date = params[:activity_date]

        if activity_date.present?
          render json: [load_single_activity(activity_date)]
        else
          render json: current_user.activities
        end
      end

      private

      def load_single_activity(activity_date)
        activity = current_user.activities.where(activity_date: Date.parse(activity_date)).first
        if activity.nil?
          activity = current_user.activities.create!(activity_date: activity_date, finalized: false)
          activity.update_activity!
        elsif activity.outdated?
          activity.update_activity!
        end

        activity
      end
    end
  end
end
