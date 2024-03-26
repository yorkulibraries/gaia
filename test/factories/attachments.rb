FactoryBot.define do

  factory :attachment do
     name { generate(:attachment_name) }
     description { nil }
     file { Rack::Test::UploadedFile.new( Rails.root + 'test/fixtures/test_pdf.pdf','application/pdf') }
     association :data_request, factory: :data_request
     association :user, factory: :user
  end

  
end
