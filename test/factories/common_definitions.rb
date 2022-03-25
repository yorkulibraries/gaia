FactoryGirl.define do
  sequence(:random_string) {|n| "Lorem Ipsum is simply dummy text#{n}" }
  sequence(:email) {|n| "email-#{n}@email.com" }
  sequence(:name) {|n| "John the #{n}st" }
  sequence(:username) {|n| "john#{n}" }
  sequence(:attachment_name) { |n| "Some Name of Attachment #{n}"}
  sequence(:dataset_name) {|n| "Dataset #{n}" }
  sequence(:random_digit) { rand(1..99) }
  sequence(:course_name) {|n| "AP/LP EN #{n} Y" }

end
