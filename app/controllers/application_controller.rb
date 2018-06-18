class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user_from_token, except: [:token]

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

  private

  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| @person = User.find_by(auth_token: token) || Admin.find_by(auth_token: token) }
      render json: { error: 'Bad Token'}, status: 401
    end
  end
end
