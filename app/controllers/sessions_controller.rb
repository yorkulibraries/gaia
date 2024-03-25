class SessionsController < ApplicationController
  skip_authorization_check

  def new

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
    render :layout => "simple"
  end


  def destroy
    session[:user_id] = nil

    cookies.delete("mayaauth", :domain => 'yorku.ca')
    cookies.delete("pybpp", :domain => 'yorku.ca')

    redirect_to "http://www.library.yorku.ca"
  end


  # TERMS OF USE
  def terms_of_use
  end

  def accept_terms
     session[:terms_accepted] = true
     redirect_to requests_user_url(current_user)
  end
end
