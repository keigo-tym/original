class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["ORIGINAL_BASIC_AUTH_USER"] && password == ENV["ORIGINAL_BASIC_AUTH_PASSWORD"]
    end
  end
end
