class HomeController < ApplicationController
  before_action :login_required
  authorize_resource :user

  def index
    if current_user.role == User::REGULAR_USER_ROLE
      redirect_to requests_user_url(current_user)
    else
      redirect_to data_requests_url
    end
  end

  def unauthorized
  end
end
