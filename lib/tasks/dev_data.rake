namespace :db do   
  desc "Erase and fill database"
  task :dev_data => :environment do
    require 'populator'
    require 'faker'
        
    [User, DataRequest].each(&:delete_all)
    
    puts "Creating Dev Users \n====="
    
    [User::STAFF_ROLE,User::MANAGER_ROLE, User::REGULAR_USER_ROLE].each do |role|
      user = User.new
      user.username = "#{role}"
      user.email = "#{role}@library-york-test.ca"
      user.name = "#{role} User"
      user.role = role
      user.usertype = "DEV:USER"
      user.deleted = false
      user.save
    end

    #Faculty User Type
    user = User.new
    user.username = "faculty"
    user.email = "FacultyUser@library-york-test.ca"
    user.name = "Regular Faculty User"
    user.role = User::REGULAR_USER_ROLE
    user.usertype = User::FACULTY
    user.deleted = false
    user.save
    
    completing_user = User.first
    
    puts "Creating Regular Users"
    User.populate 20 do |u|
      u.username = Faker::Internet.user_name
      u.email = "#{u.username}@library-york-test.ca"
      u.name = Faker::Name.name
      u.role = User::REGULAR_USER_ROLE
      u.usertype = ["EMPLOYEE:STAFF", "EMPLOYEE:FACULTY", "STUDENT:UNDERGRAD", "STUDENT:GRAD"]
      u.deleted = false
    end
    
    puts "Data Requests"
    
    User.all.each do |user|
      DataRequest.populate 2 do |request|
        request.datasets = ["Ontario Wind Power Allocation", "Europe Wind Power Allocation", "Asia Wind Power Allocation", "Australia Property Data Maps (56m-23, 57m-21, 57m-22)", "Request about North America Property Data Maps (56m-23, 57m-21, 57m-22)", "City of Toronto Property Data Maps (56m-23, 57m-21, 57m-22)"]
        request.course = [true, false]
        if request.course == true
          request.course_info = ["AS/SOCI 4010, Summer 2013", "AS/SOCI 4010, Winter 2014", "AS/SOCI 4010, Summer 2014", "NATS 1340", "NATS 2010 Fall 2013", "GEO 3045 Winter 2014", "GEO 5600 Winter 2014", "AS/GEO 4050, Summer 2013"]
        end
        request.project_description = Populator.words(10..20) 
        request.supervisor = Faker::Name.name
        request.phone = Faker::PhoneNumber.phone_number
        request.alt_email = "#{user.username}@other-library-york-test.ca"
        request.project_due_date = 1.month.from_now..6.months.from_now
        request.other_info = ["Asia Minor", "Middle East and North Africa", "Northern Europe excluding Denmark and Sweden", "Southern Italy, Naples, Milan, Turin"]
        request.cancellation_reason = Populator.words(10..20)
        request.participants_count = 1..5
        request.requested_by_id = user.id
        request.requested_date = 1.month.ago..1.week.ago
        request.expires_after = 1.week.ago..2.months.from_now
        request.status = [DataRequest::OPEN, DataRequest::FILLED, DataRequest::CANCELLED, DataRequest::EXPIRED]
        
        if request.status == DataRequest::FILLED || request.status == DataRequest::CANCELLED
          request.completed_by_id = completing_user.id
          request.completed_date = Date.today
        end        
        
        if request.status == DataRequest::EXPIRED
          request.completed_by_id = completing_user.id
          request.completed_date = Date.today
          request.expires_after = 1.month.ago..1.week.ago
        end
          

      end
    end

    DataRequest.all.each do |request|
      # Add Terms of Agreement for data request created. 
      terms_path = Rails.root + 'public/Conditions_of_use_agreement.docx'
      attachment = request.attachments.new
      attachment.file = File.open(terms_path)
      attachment.name = "Conditions of Use"
      attachment.save
    end
    
    
  end
end