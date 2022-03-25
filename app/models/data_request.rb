class DataRequest < ApplicationRecord
  #attr_accessible :course, :course_info, :project_description, :supervisor, :phone, :alt_email, :project_due_date, :datasets, :other_info, :participants_count, :participants_names, :cancellation_reason, :expires_after, :completed_date, :status

  has_many :attachments

  belongs_to :requested_by, foreign_key: "requested_by_id", class_name: "User"
  belongs_to :completed_by, foreign_key: "completed_by_id", class_name: "User"

  ## VALIDATIONS
  validates_inclusion_of :course, in: [true, false]
  validates :project_due_date, presence: true
  validates :phone, presence: true
  validates :alt_email, presence: true

  # if there are more than 1 participants, there should be listed in  names box. Cannot be empty.
  validates_presence_of :participants_names, :if => Proc.new { |o| o.participants_count > 1 }
  validates_length_of :project_description, :maximum => 230
  validates_format_of :alt_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Invalid email format."

  #### Status Constants #######

  OPEN = "open"
  FILLED = "filled"
  CANCELLED = "cancelled"
  EXPIRED = "expired"
  STATUSES = [OPEN, FILLED, CANCELLED, EXPIRED]

  #EXPIRES_AFTER_DATES = [["A week from now", 1.week.from_now.to_date], ["A month from now", 1.month.from_now.to_date], ["3 months from now", 3.months.from_now.to_date],
  #                       ["In 6 months", 6.months.from_now.to_date], ["In one year", 1.year.from_now.to_date], ["Never", nil]]

  scope :opened, -> { where("status = ?", OPEN) }
  scope :open_or_filled, -> { where("status = ? OR status = ?", OPEN, FILLED) }
  scope :filled, -> { where("status = ?", FILLED) }
  scope :cancelled, -> { where("status = ?", CANCELLED) }
  scope :expired, -> { where("status = ?", EXPIRED) }


  ## METHODS ##

  def fill(expires_after, completed_by_user)
    if completed_by_user
      self.status = FILLED
      self.expires_after = expires_after
      self.completed_by = completed_by_user
      self.completed_date = Date.today

      save(validate: false)
    end
  end

  def expire_request()
    if self.expires_after < Date.today
      self.status = EXPIRED
      save(validate: false)
    end
  end

  def self.expires_after_dates
    [
      ["A week from now", 1.week.from_now.to_date],
      ["A month from now", 1.month.from_now.to_date],
      ["3 months from now", 3.months.from_now.to_date],
      ["In 6 months", 6.months.from_now.to_date],
      ["In one year", 1.year.from_now.to_date],
      ["Never", nil]
    ]
  end

end
