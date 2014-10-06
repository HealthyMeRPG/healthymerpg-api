module Api
  module V1
    class SessionsController < ::ApplicationController
      def create
        user = User.authenticate(login_params[:email], login_params[:password])
        if user
          session = UserSession.create({
            user: user
          })
          session.access(request)
          render json: session, status: 201
          return
        end

        render json: { error: 'Invalid credentials' }, status: 401
      end

      def destroy
      end

      private

      def login_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
