class SessionsController < ApplicationController
  skip_authorization_check

  def new
    if !request.headers['HTTP_PYORK_USER']
      return redirect_to invalid_login_url
    end

    pyi = {
      name: "#{request.headers['HTTP_PYORK_FIRSTNAME']} #{request.headers['HTTP_PYORK_SURNAME']}",
      username: request.headers['HTTP_PYORK_USER'],
      usertype: request.headers['HTTP_PYORK_TYPE'],
      email: request.headers['HTTP_PYORK_EMAIL']
    }

    @user = User.find_or_create(pyi)

    session[:user_id] = @user.id
    if @user.role == User::REGULAR_USER_ROLE
      redirect_to terms_of_use_url, notice: "Logged in!"
    else
      redirect_to data_requests_url, notice: "Logged in!"
    end
  end

  def invalid_login
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to "https://passportyork.yorku.ca/ppylogin/ppylogout", allow_other_host: true
  end

  # TERMS OF USE
  def terms_of_use
  end

  def accept_terms
     session[:terms_accepted] = true
     redirect_to requests_user_url(current_user)
  end
end
