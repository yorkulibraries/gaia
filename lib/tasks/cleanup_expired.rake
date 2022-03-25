
namespace :maintenance do
  desc "Clean up expired request attachments"
  
  task :update_status_of_expired => :environment do

    puts "Fetching expired requests"     
    data_requests = DataRequest.where("expires_after < ? AND status != ?", Date.today, DataRequest::EXPIRED)
    puts "Found #{data_requests.count} expired requests"

    data_requests.each do |dq|
      puts "#{dq.id} : #{dq.status} : expired: #{dq.expires_after} : #{dq.attachments.count}"
      dq.expire_request
      puts "#{dq.id} : #{dq.status} : expired: #{dq.expires_after} : #{dq.attachments.count}"
    end    
    
  end

  task :delete_expired_attachments => :environment do

    puts "Fetching expired status requests"
    data_requests = DataRequest.expired
    
    puts "Found #{data_requests.count} expired requests"
    
    if data_requests.count > 0 
      puts "************* BEFORE DELETE *****************"
      
      data_requests.each do |dq|
        puts "#{dq.id} : #{dq.status} : expired: #{dq.expires_after} : #{dq.attachments.count}"
      end

      puts "Deleting attachments"
      data_requests.each do |dq|
        if dq.attachments.count > 0
          for attachment in dq.attachments.all
            attachment.destroy
          end
        end
      end
      puts "************* AFTER DELETE *****************"
      data_requests.each do |dq|
        puts "#{dq.id} : #{dq.status} : expired: #{dq.expires_after} : #{dq.attachments.count}"
      end
    end
  end
end
