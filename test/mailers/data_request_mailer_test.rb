require 'test_helper'

class DataRequestMailerTest < ActionMailer::TestCase

  should "deliver email about cancel notification" do

    user = create(:user, email: "dummy@email.com", name: "John Doe", role: User::REGULAR_USER_ROLE)
    request = create(:data_request, status: DataRequest::OPEN, requested_by: user, alt_email: "dummy@email.com")

    mail = DataRequestMailer.cancel_confirmation(user, request).deliver_now

    assert !ActionMailer::Base.deliveries.empty?

    assert_equal "Your Data Request has been Cancelled", mail.subject

    assert_equal user.email, mail.to.first

    assert_match /Your Request: #{request.datasets} from #{request.created_at} has been cancelled./, mail.encoded

  end

  should "deliver email about new request notification" do

    user = create(:user, email: "dummy@email.com", name: "John Doe", role: User::REGULAR_USER_ROLE)
    request = create(:data_request, status: DataRequest::OPEN, requested_by: user, alt_email: "dummy@email.com")

    mail = DataRequestMailer.new_request_confirmation(user, request).deliver_now

    assert !ActionMailer::Base.deliveries.empty?

    assert_equal "New Data Request has been submitted", mail.subject

    assert_equal user.email, mail.to.first

    assert_match /Thank you for your geospatial data request./, mail.encoded

  end

  should "deliver email about filled request notification" do

    user = create(:user, email: "dummy@email.com", name: "John Doe", role: User::REGULAR_USER_ROLE)
    request = create(:data_request, status: DataRequest::OPEN, requested_by: user, alt_email: "dummy@email.com")

    mail = DataRequestMailer.filled_request_notification(user, request).deliver_now

    assert !ActionMailer::Base.deliveries.empty?

    assert_equal "Your Data Request has been filled", mail.subject

    assert_equal user.email, mail.to.first

    assert_match /Your geospatial data request is now ready for download./, mail.encoded

  end

end
