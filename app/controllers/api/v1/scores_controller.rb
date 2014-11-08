module Api
  module V1
    class ScoresController < ::ApplicationController
      before_action :require_user_session!

      def show
        render json: Score.for_user(current_user).find(params[:id])
      end
    end
  end
end
