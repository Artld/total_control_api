class ApplicationController < ActionController::API
  # Methods missing in API-only application
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user_from_token, except: [:token]

  # Get token from "name:password" or "email:password" string
  def token
    authenticate_with_http_basic do |string, password|
      person = User.find_by(name: string) || Admin.find_by(email: string)
      if person && person.password == password
        render json: { token: person.auth_token }
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  # Deny access for non-admins
  def check_if_admin
    render json: { error: 'Access denied' }, status: 401 unless @is_admin
  end

  private

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, _options| @person = User.find_by(auth_token: token) || Admin.find_by(auth_token: token) }
      render json: { error: 'Bad Token' }, status: 401
    end
    @is_admin = @person.class == Admin
  end
end
