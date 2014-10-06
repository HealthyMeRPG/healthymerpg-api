class ApplicationController < ActionController::API
  include ActionController::StrongParameters

  before_action :authenticate_user_from_token!

  private

  def current_user
    @current_user ||= @current_session.try(:user)
  end

  def authenticate_user_from_token!
    authorization_header = request.headers['Authorization']
    return unless authorization_header.present?

    # The "Authorization" header that Ember appends to all AJAX requests is in this format:
    #   Token token="...", user_email="..."
    # The `token_chunks` regular expression grabs the token and user_email portion and looks up
    # a user session based on that information
    token_chunks = /^Token token="(?<token>[a-zA-Z0-9\-_]+)", user_email="(?<email>.*)"$/.match(authorization_header)
    user_email = token_chunks[:email]
    user_token = token_chunks[:token]

    @current_session = UserSession.active.joins(:user).where(users: { email: user_email }, key: user_token).first if user_email.present? && user_token.present?
    @current_session.access(request) if @current_session.present?
  end

  def require_user_session!
    # if `current_user` returns nil, this method will return an
    # HTTP error code 401 (Unauthorized), and will skip running any
    # more code
    unless current_user.present?
      render json: { message: 'You must be logged in to view this page' }, status: 401
    end
  end
end
