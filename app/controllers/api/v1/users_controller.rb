module Api
  module V1
    class UsersController < ::ApplicationController
      before_action :require_user_session!, only: [:me]

      def create
        user = User.new(register_params)
        if user.save
          render json: user, status: 201
        else
          render json: { errors: user.errors.full_messages }, status: 422
        end
      end

      def me
        render json: current_user
      end

      private

      def register_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
      end
    end
  end
end
