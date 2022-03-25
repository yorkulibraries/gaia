require 'test_helper'

class DataRequestTest < ActiveSupport::TestCase

  should "create a valid data_request" do
    data_request = build(:data_request)
    assert_difference "DataRequest.count", 1 do
      data_request.save
    end
  end
    
  should "not create an invalid data_request" do
    assert ! build(:data_request, course: nil).valid?, "Course boolean is required"
    assert ! build(:data_request, project_due_date: nil).valid?, "Request Project Due Date is required"
    assert ! build(:data_request, phone: nil).valid?, "Request Phone is required"
    assert ! build(:data_request, alt_email: nil).valid?, "Request Alt Email is required"    
    assert ! build(:data_request, alt_email: "randomfakenonworkingemail.com").valid?, "Email must follow a user@email.com format"
    
  end
  
  should "show records based on status" do
    create_list(:data_request, 2, status: DataRequest::OPEN)
    create_list(:data_request, 5, status: DataRequest::FILLED)
    create_list(:data_request, 3, status: DataRequest::CANCELLED)
    create_list(:data_request, 1, status: DataRequest::EXPIRED)    
    
    assert_equal 2, DataRequest.opened.count, "Data Request show only open statuses count failed"
    assert_equal 5, DataRequest.filled.count, "Data Request show only filled statuses count failed"
    assert_equal 3, DataRequest.cancelled.count, "Data Request show only cancelled statuses count failed"
    assert_equal 1, DataRequest.expired.count, "Data Request show only expired statuses count failed"    
  end
  
  
  should "change the status to filled, ensure that email is sent to requester" do
    request = create(:data_request, status: DataRequest::OPEN)
    user = create(:user)
    
    expires_after = 1.month.from_now
    request.fill(expires_after, user)
    
    request.reload
    assert_equal DataRequest::FILLED, request.status, "Status should be filled"
    assert_equal expires_after.to_date, request.expires_after, "dates match"
    assert_equal user.id, request.completed_by.id, "Completed By was set"
    assert_equal Date.today.to_date, request.completed_date.to_date, "Completed is set to today"
  end

  should "change the status to expired if older than today" do
    request = create(:data_request, status: DataRequest::OPEN, expires_after: Date.today - 2.days)
    
    request.expire_request
    
    request.reload
    assert_equal DataRequest::EXPIRED, request.status, "Status should be expired"

  end
  
  should "have participants names if participants count greater than 1" do
    assert ! build(:data_request, participants_names: "").valid?, "Count is > 1, there should be participant names / info"
  end
  
end
