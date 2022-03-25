class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  before_action :redirect_if_terms_accepted, if: lambda { |c| current_user && current_user.role == User::REGULAR_USER_ROLE}

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end

  def login_required
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to unauthorized_url, :alert => "#{exception.message}"
  end

  private

  def redirect_if_terms_accepted
    if controller_name == "sessions"
      true
    elsif session[:terms_accepted]
      true
    else
      redirect_to terms_of_use_url
    end
  end

end
