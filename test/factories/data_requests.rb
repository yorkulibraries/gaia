FactoryBot.define do
  factory :data_request do
    course { true }
    project_description { generate(:random_string) }
    course_info { generate(:course_name) }
    supervisor { generate(:name) }
    phone { "1234567" }
    alt_email { generate(:email) }
    project_due_date { 1.month.from_now.to_s(:db) }
    datasets { generate(:random_string) }
    other_info { generate(:random_string) }
    participants_names { "John Doe, York Student, j@email.com \nJane Doe, York Faculty, jd@email.com" }
    participants_count { 2 }
    cancellation_reason { nil }
    association :requested_by, factory: :user
    requested_date { "2013-04-17" }
    association :completed_by, factory: :user
    expires_after { 2.month.from_now.to_s(:db) }
    completed_date { "" }
    status { DataRequest::OPEN }
  end
  
end
