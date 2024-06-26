class DataRequestMailer < ActionMailer::Base
  default from: Rails.configuration.gaia_settings[:mail][:from_email]

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

  def new_request_confirmation(user=nil, data_request=nil, manager=Rails.configuration.gaia_settings[:mail][:support_email])
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

      mail(to:Rails.configuration.gaia_settings['mail']['manager_email'], cc: ccd, subject: "New Data Request has been submitted")

    end

  end

  def filled_request_notification(user=nil, data_request=nil, manager=Rails.configuration.gaia_settings[:mail][:support_email])

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
