class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new
     
     if user.role == User::ADMIN_ROLE || user.role == User::MANAGER_ROLE
       can :manage, :all
     elsif user.role == User::STAFF_ROLE
       can :manage, [DataRequest, Attachment]
       can :read, User
      
       can [:read, :requests], User do |u|
          u.id == user.id
      end
        
     else
       can [ :terms_of_use, :accept_terms], User
       can [:read, :requests], User do |u|
         u.id == user.id
       end
       
       
       can :read, DataRequest, requested_by_id: user.id
       can :create, DataRequest
                       
       can :read, Attachment do |file|
          file.data_request.requested_by.id == user.id
       end
       
     end
  end
end
