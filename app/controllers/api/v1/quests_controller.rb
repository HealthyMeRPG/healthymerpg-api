module Api
  module V1
    class QuestsController < ::ApplicationController
      before_action :require_user_session!

      def index
        render json: Quest.all
      end
    end
  end
end
