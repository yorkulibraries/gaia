class DataRequestMailer < ActionMailer::Base
  default from: "email@set.in.config.file"

  def cancel_confirmation(user=nil, data_request=nil)

    if user == nil || data_request == nil
      puts "ERROR: New Cancel Confirmation::User or data request is nil"
    else
      @user = user
      @data_request = data_request

      @greeting = "Hello  #{user.name}"

      mail(to:"#{data_request.alt_email}", subject: "Your Data Request has been Cancelled")

    end
  end

  def new_request_confirmation(user=nil, data_request=nil, manager='email@set.in.config.file')

    if user == nil || data_request == nil
      puts "ERROR: New Request Confirmation::User or data request is nil"
    else
      @user = user
      @data_request = data_request

      @greeting = "Hello #{user.name},"

      mail(to:"#{data_request.alt_email}", bcc: "#{manager}", subject: "New Data Request has been submitted")

    end
  end

  def new_request_notification(data_request=nil)

    if data_request == nil
      puts "ERROR: New Request Notification::data request is nil"
    else
      @data_request = data_request

      @greeting = "Hello Gaia Administrator,"

      @admins = User.where(role: ["manager", "staff"])

      ccd = ""

      @admins.each do |u|
        ccd << "#{u.email}, "
      end

      if Rails.env.development? || Rails.env.test?
        mail(to:"email@set.in.config.file", subject: "DEV: New Data Request has been submitted")
      else
        mail(to:"email@set.in.config.file", cc: ccd, subject: "New Data Request has been submitted")
      end

    end

  end

  def filled_request_notification(user=nil, data_request=nil, manager='email@set.in.config.file')

    if user == nil || data_request == nil
      puts "ERROR: New Filled Confirmation::User or data request is nil"
    else
      @user = user
      @data_request = data_request

      @greeting = "Hello  #{user.name}"

      mail(to:"#{data_request.alt_email}", subject: "Your Data Request has been filled")

    end
  end
end
