if (Rails.env != 'test') && User.all.count.zero?
  [User::ADMIN_ROLE, User::MANAGER_ROLE, User::STAFF_ROLE].each do |role|
    user = User.new
    user.username = "#{role}"
    user.email = "#{role}@localhost.localdomain"
    user.name = "#{role} User"
    user.role = role
    user.usertype = "EMPLOYEE:STAFF"
    user.deleted = false
    user.save
  end
end
