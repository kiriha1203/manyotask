class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  http_basic_authenticate_with :name =>ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end
end
