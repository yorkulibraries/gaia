class CreateDataRequests < ActiveRecord::Migration[5.1]
  def self.up
    create_table :data_requests do |t|
      t.boolean :course, default: true
      t.string :course_info
      t.string :project_description
      t.string :supervisor
      t.string :phone
      t.string :alt_email
      t.date :project_due_date
      t.text :datasets
      t.text :other_info
      t.text :cancellation_reason
      t.integer :participants_count, default: 1
      t.integer :requested_by_id
      t.date :requested_date
      t.integer :completed_by_id
      t.date :expires_after
      t.date :completed_date
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :data_requests
  end
end
