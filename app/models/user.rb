class User < ApplicationRecord
  # hidden :usertype, :username, :deleted
  #attr_accessible :name, :email, :role


  has_many :datasets
  has_many :data_requests, foreign_key: "requested_by_id"
  has_many :attachments

  #### CONSTANTS
  ADMIN_ROLE = "admin"
  MANAGER_ROLE = "manager"
  STAFF_ROLE = "staff"
  REGULAR_USER_ROLE = "regular_user"
  ROLES = [ADMIN_ROLE, MANAGER_ROLE, STAFF_ROLE, REGULAR_USER_ROLE]

  FACULTY = "EMPLOYEE:FACULTY"

  USER_TYPES = ["FACULTY:UNKNOWN", "EMPLOYEE:STAFF", "GRAD:STUDENT", "UNDERGRAD:STUDENT", "NONDEG:STUDENT", "UNKNOWN:UNKNOWN"]

  ### VALIDATIONS
  validates_presence_of :name, :role, :usertype
  validates :username, format: { with: /\A[\w\-@]*\z/ }, uniqueness: true, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :role, inclusion: { in: [ADMIN_ROLE, MANAGER_ROLE, STAFF_ROLE, REGULAR_USER_ROLE], message: "%{value} is not a valid role" }


  #### SCOPES
  default_scope { where(deleted: false) }
  scope :alphabetical, -> { order("name asc") }

  def self.deleted
    ## MUST BE DONE THIS WAY, unscoped doesn't play well with scopes
    unscoped.where(deleted: true).all
  end


  ### Helper Methods
  def self.find_or_create(passport_york_info)
    return nil if passport_york_info == nil

    user = User.find_by_username(passport_york_info[:username])
    if user == nil
      user = User.new
      user.username = passport_york_info[:username]
      user.usertype = passport_york_info[:usertype]
      user.name = passport_york_info[:name]
      user.email = passport_york_info[:email]
      user.role = REGULAR_USER_ROLE
      user.save
    end

    user
  end

end
