module Api
  module V1
    class TrackersController < ::ApplicationController
      before_action :require_user_session!

      def index
        render json: current_user.trackers.authorized
      end

      def destroy
        tracker = Tracker.active.authorized.find(destroy_params[:id])
        tracker.deauthorize!

        render json: { success: true }
      end

      private

      def destroy_params
        params.permit(:id)
      end
    end
  end
end
