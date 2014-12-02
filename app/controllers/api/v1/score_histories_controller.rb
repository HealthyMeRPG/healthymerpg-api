module Api
  module V1
    class ScoreHistoriesController < ::ApplicationController
      before_action :require_user_session!

      def index
        render json: ScoreHistory.all
      end
    end
  end
end
