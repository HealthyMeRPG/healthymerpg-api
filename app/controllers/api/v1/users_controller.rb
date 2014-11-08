module Api
  module V1
    class UsersController < ::ApplicationController
      before_action :require_user_session!, only: [:me]

      def create
        user = User.new(register_params)
        if user.save
          user.create_score(stamina: 90, strength: 90, mind: 90, vitality: 90, agility: 90)
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
