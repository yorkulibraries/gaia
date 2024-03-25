FactoryBot.define do
  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    username { generate(:username) }
    usertype { "UNDERGRAD" }
    role { User::MANAGER_ROLE }
    deleted { false }
  end
end
