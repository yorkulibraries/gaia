require 'test_helper'

class AttachmentsControllerTest < ActionController::TestCase
    ##### DISPLAYING #######
    context "Manager user logged in" do
      setup do
        @user = create(:user, role: User::MANAGER_ROLE)
        log_user_in @user
      end

      should "show a list of attachments for a data_request" do

        data_request = create(:data_request)

        create_list(:attachment, 5, data_request: data_request)

        get :index, params: {data_request_id: data_request.id}

        assert_response :success
        assert_template :index

        attachments = assigns(:attachments)
        assert_not_nil attachments, "Attachment object wasn't assigned"
        assert_equal 5, attachments.count, "There must be 5 attachments"
      end


      ###### CREATING ######

      should "show new form" do
        data_request = create(:data_request)

        get :new, params: {data_request_id: data_request.id }

        assert_response :success
        assert_template :new
        assert assigns(:attachment), "Didn't assign attachment object"

      end

      should "create an attachment" do
        data_request = create(:data_request)

        assert_difference('Attachment.count') do
          post :create, params: { attachment: attributes_for(:attachment), data_request_id: data_request.id }
        end
      end

      #### DESTROYING ######
      should "delete an existing attachment if data_request status is OPEN" do

        data_request = create(:data_request, status: DataRequest::OPEN)

        dr_attachment = create(:attachment, data_request: data_request)

        delete :destroy, params: {data_request_id: data_request.id, id: dr_attachment.id}

        assert_response :redirect
        assert_redirected_to data_request_url
        assert !Attachment.exists?(dr_attachment.id), "Attachment should have been deleted."

      end

      should "not delete the attachment if data request status is filled" do

        data_request = create(:data_request, status: DataRequest::FILLED)

        dr_attachment = create(:attachment, data_request: data_request)

        delete :destroy, params: {data_request_id: data_request.id, id: dr_attachment.id}

        assert_response :redirect
        assert_redirected_to data_request_url
        assert Attachment.exists?(dr_attachment.id), "Attachment should have NOT been deleted for FILLED Requests"

      end

    #TODO: Figure out how to test for edit and update to not show or raise errors / catch them

    # Integration / View Test: "Delete should not display for filled requests"

  end # Context Close


  context "Regular User " do
    setup do
      @user = create(:user, role: User::REGULAR_USER_ROLE)
      log_user_in @user
    end

    should "show terms if not accepted" do
      data_request = create(:data_request)
      get :index, params: {data_request_id: data_request.id }

      assert_redirected_to terms_of_use_url
    end
  end

end
