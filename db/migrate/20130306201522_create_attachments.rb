class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :name
      t.text :description
      t.integer :created_by_id
      t.integer :data_request_id
      t.string :file
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
