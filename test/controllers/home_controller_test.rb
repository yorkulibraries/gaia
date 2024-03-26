require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  context "As multiple users" do
    setup do
      @user = create(:user)
      log_user_in @user
    end

    should "redirect to data requests url if Staff or MANAGER" do
      @user.update(:role, User::MANAGER_ROLE)
      get :index, params: {}
      assert_response :redirect
      assert_redirected_to data_requests_url, "Goes to all data requests"
    end


    should "redirect to data requests url if REGULAR USER" do
      @user.update(:role, User::REGULAR_USER_ROLE)
      session[:terms_accepted] = true
      get :index, params: {}
      assert_response :redirect
      assert_redirected_to requests_user_url(@user), "Goes to user's requests"
    end
  end

  context "Regular User " do
    setup do
      @user = create(:user, role: User::REGULAR_USER_ROLE)
      log_user_in @user
    end

    should "show terms if not accepted" do

      get :index, params: {}
      assert_response :redirect
      assert_redirected_to terms_of_use_url
    end

    should "redirect to data requests url if terms accepted" do

      session[:terms_accepted] = true
      get :index, params: {}
      assert_response :redirect
      assert_redirected_to requests_user_url(@user), "Goes to user's requests"
    end

  end

end
