module Api
  module V1
    # handles authorizing fitness trackers
    class AuthorizeController < ::ApplicationController
      include ::OmhCommunication

      before_action :require_user_session!, except: [:tracker_callback]

      def fitbit
        authorization_url = authorization_request(:fitbit)
        render json: { url: authorization_url }
      end

      def jawbone
        authorization_url = authorization_request(:jawbone)
        render json: { url: authorization_url }
      end

      def tracker_callback
        tracker = Tracker.active.where(omh_shim_id: callback_params[:state]).first
        tracker.authorize!(callback_params)

        redirect_to('/trackers')
      end

      private

      def callback_params
        params.permit(:state, :oauth_token, :oauth_verifier)
      end
    end
  end
end
