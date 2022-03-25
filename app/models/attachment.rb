class Attachment < ApplicationRecord
  #attr_accessible :name, :description, :file

  belongs_to :data_request
  belongs_to :user, foreign_key: "created_by_id"

  mount_uploader :file, AttachmentUploader

  before_create :default_name

  ## VALIDATIONS
  validates :file, presence: { message: "Please select the file to upload." }

  def default_name
    self.name = File.basename(file.filename, '.*').titleize if self.name.blank?
  end
end
