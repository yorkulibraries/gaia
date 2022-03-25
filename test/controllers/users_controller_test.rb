require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context "Manager user" do
    setup do
      @user = create(:user)
      log_user_in @user
    end


    ##### DISPLAYING #######

    should "show a list of users" do
      create_list(:user, 5)

      get :index, params: {}

      assert_response :success
      assert_template :index

      # users = assigns(:users)
      # assert users, "Users model was not assigned"
      assert_equal 6, User.count, "There must be 5 + 1users"
    end

    should "show one user" do
      u = create(:user, name: "John Doe")

      get :show, params: {id: u.id}

      assert_response :success
      assert_template :show

      user = assigns(:user)
      assert user, "User object wasn't assigned"
      assert_equal "John Doe", user.name, "Names didn't match"
    end


    ###### CREATING ######
    should "show new form" do

      get :new, params: {}

      assert_response :success
      assert_template :new

      assert assigns(:user), "Didn't assign user object"
    end

    should "create a new user" do

      assert_difference "User.count", 1 do
        post :create, params: {user: { name: "John", email: "email@email.com", role: User::STAFF_ROLE }}

        user = assigns(:user)
        assert_equal 0, user.errors.size, "Found Errors, #{user.errors.inspect}"
        assert_response :redirect
        assert_redirected_to user_path(user), "Didn't redirect to user page"

        #### BY DEFAULT generate a username from name
        assert_equal user.name.parameterize, user.username, "Name wasn't used to generate default username"
        assert_equal "UNDERGRAD", user.usertype, "UNDERGRAD was not set as default"
      end
    end

    ###### UPDATING ######
    should "show edit form" do
      u = create(:user)

      get :edit, params: { id: u.id }

      assert_response :success
      assert_template :edit

      user = assigns(:user)
      assert user, "User object was not assigned properly"
      assert_equal u.id, user.id, "Make sure its the correct user"
    end

    should "update an existing user" do
      u = create(:user, name: "Some Joe")

      post :update, params: { id: u.id, user: { name: "John Doe"} }

      user = assigns(:user)
      assert_equal 0, user.errors.size, "Found Errors: #{user.errors.inspect}"
      assert_response :redirect
      assert_redirected_to user_path(user), "Didn't redirect properperly"

      assert_equal "John Doe", user.name, "Name didn't change"
    end


    #### DESTROYING THE USER ######
    should "set the deleted flag and not destroy the user" do
      u = create(:user, deleted: false)

      assert_difference "User.count", -1 do
        delete :destroy, params: {id: u.id}

        assert_response :redirect
        assert_redirected_to users_url, "Didn't redirect to users_url"

        user = assigns(:user)
        assert user, "User object was not assigned"
        assert user.deleted?, "User's deleted flag was not set"
      end
    end
  end

  context "Regular user" do
    setup do
      @user = create(:user, role: User::REGULAR_USER_ROLE)
      session[:terms_accepted] = true
      log_user_in @user
    end

    should "show data requests for this user" do
      create_list(:data_request, 2, requested_by: @user)
      create(:data_request, requested_by: create(:user))

      get :requests, params: {id: @user.id}
      assert_response :success
      assert_template :requests

      requests = assigns(:data_requests)
      assert requests, "Ensure assigns requests"
      assert_equal 2, requests.size, "Found two requests requested by user"
    end

    should "group requests open first, filled after, not expired or cancelled ones" do
      cancelled = create(:data_request, requested_by: @user, status: DataRequest::CANCELLED)
      filled = create(:data_request, requested_by: @user, status: DataRequest::FILLED)
      open = create(:data_request, requested_by: @user, status: DataRequest::OPEN)

      get :requests, params: {id: @user.id}
      requests = assigns(:data_requests)
      assert_equal 2, requests.size, "only two requests"
      assert_equal open.id, requests.first.id
      assert_equal filled.id, requests.last.id
    end
  end


  context "Regular User - Terms Accepted Tests" do
     setup do
       @user = create(:user, role: User::REGULAR_USER_ROLE)
       log_user_in @user
     end

     should "show terms if not accepted" do
       data_request = create(:data_request)
        get :requests, params: { id: @user.id}

       assert_redirected_to terms_of_use_url
     end

     should "redirect to data requests url if terms accepted" do
       session[:terms_accepted] = true
       get :requests, params: { id: @user.id }
       assert_response :success
     end
   end
end
