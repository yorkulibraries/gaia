require 'test_helper'

class DataRequestsControllerTest < ActionController::TestCase


  context "Manager User" do
    setup do
      @user = create(:user, name: "John Doe", role: User::MANAGER_ROLE)
      log_user_in @user
    end

    should "show list of data request with or without status " do

      create_list(:data_request, 3, status: DataRequest::OPEN)
      create_list(:data_request, 4, status: DataRequest::FILLED)
      create_list(:data_request, 5, status: DataRequest::CANCELLED)
      create_list(:data_request, 2, status: DataRequest::EXPIRED)

      get :index, params: {} # should default to open_or_filled.
      assert_response :success
      assert_template :index

      data_requests = assigns(:data_requests)
      assert_not_nil data_requests, "Dataset object wasn't assigned"
      assert_equal 3, data_requests.count, "There must be 3 data_requests, defaults to OPEN"

      get :index, params: {status: DataRequest::OPEN}
      data_requests = assigns(:data_requests)
      assert_equal 3, data_requests.count, "There must be 3 OPEN data_requests"

      get :index, params: {status: DataRequest::FILLED}
      data_requests = assigns(:data_requests)
      assert_equal 4, data_requests.count, "There must be 4 FILLED data_requests"

      get :index, params: {status: DataRequest::CANCELLED}
      data_requests = assigns(:data_requests)
      assert_equal 5, data_requests.count, "There must be 5 CANCELLED data_requests"

      get :index, params: {status: DataRequest::EXPIRED}
      data_requests = assigns(:data_requests)
      assert_equal 2, data_requests.count, "There must be 2 EXPIRED data_requests"

    end

    ### Show ###
    should "show one data_request" do
      d = create(:data_request, datasets: "test request")

      get :show, params: {id: d.id}

      assert_response :success
      assert_template :show

      data_request = assigns(:data_request)
      assert data_request, "Data Request object wasn't assigned"
      assert_equal "test request", data_request.datasets, "datasets name didn't match"
    end

    ###### CREATING ######

    should "show new form" do

      get :new, params: {}

      assert_response :success
      assert_template :new

      assert assigns(:data_request), "Didn't assign data_request object"
    end

    should "create a new request" do
      assert_difference "DataRequest.count", 1 do
        post :create, params: {data_request: attributes_for(:data_request).except(:completed_by, :requested_by, :requested_date)}
        request = assigns(:data_request)
        assert_equal 0, request.errors.size, "Should be no errors, #{request.errors.messages.inspect}"
        assert_response :redirect
        assert_redirected_to data_request_url(request)

        assert_not_nil request.requested_date, "Requested Date must be set"
        assert_equal Date.today.to_date, request.requested_date.to_date, "Ensure the date is set"
        assert_equal @user.id, request.requested_by.id, "Set requested by id"
      end
    end

    ###### UPDATING ######

    should "show edit form" do
      d = create(:data_request)

      get :edit, params: {id: d.id}

      assert_response :success
      assert_template :edit

      data_request = assigns(:data_request)
      assert data_request, "Data_request object was not assigned properly"
      assert_equal d.id, data_request.id, "Make sure its the correct user"
    end

    should "update an existing data_request that is VALID" do
      d = create(:data_request, datasets: "test request")

      post :update, params: {id: d.id, data_request: { datasets: "test request 2"}}

      data_request = assigns(:data_request)
      assert_equal 0, data_request.errors.size, "Found Errors: #{data_request.errors.inspect}"
      assert_response :redirect
      assert_redirected_to data_request_path(data_request), "Didn't redirect properperly"

      assert_equal "test request 2", data_request.datasets, "course_info didn't change"
    end

    #### DESTROYING ######
    should "delete an existing data_request" do

      data_request = create(:data_request)

      delete :destroy, params: {id: data_request.id}

      assert_response :redirect
      assert_redirected_to data_requests_url
      assert !DataRequest.exists?(data_request.id)

    end

    #### FILLING REQUEST ####
    should "fill request, and set the expires_after date and who filled it" do
      request = create(:data_request, status: DataRequest::OPEN)

      post :fill, params: {id: request.id, data_request: { expires_after: 1.month.from_now }}
      assert_response :redirect
      assert_redirected_to request, "Redirect back to request"

      data_request = assigns(:data_request)
      assert_equal DataRequest::FILLED, data_request.status
      assert_equal @user.id, data_request.completed_by.id, "Current user is set as the completed by"
    end

    #### CANCELLING REQUEST ####
    should "cancel request, remove all data attachments and send email to requester" do
      request = create(:data_request, status: DataRequest::OPEN)
      attachments = create_list(:attachment, 5, data_request: request)

      post :cancel, params: {id: request.id}
      assert_response :redirect
      assert_redirected_to request, "Redirect back to request"

      data_request = assigns(:data_request)
      assert_equal DataRequest::CANCELLED, data_request.status

      assert_equal 0, request.attachments.count
    end
  end

  context "Regular User - Terms Accepted Tests" do
    setup do
      @user = create(:user, role: User::REGULAR_USER_ROLE)
      log_user_in @user
    end

    should "show terms if not accepted" do
      data_request = create(:data_request)
      get :index, params: {data_request_id: data_request.id}

      assert_redirected_to terms_of_use_url
    end

    should "redirect to data requests url if terms accepted" do
      session[:terms_accepted] = true

      data_request = create(:data_request)
      get :index, params: {data_request_id: data_request.id}

      assert_response :success
    end

    should "attach terms of agreement on data request create" do

      data_request = create(:data_request)

      attachment = create(:attachment, data_request_id: data_request.id, file: Rack::Test::UploadedFile.new(Rails.root + 'public/Terms_Of_Agreement.pdf','application/pdf'), name: "Terms_Of_Agreement")

      assert_equal 1, data_request.attachments.count

    end

  end


end
