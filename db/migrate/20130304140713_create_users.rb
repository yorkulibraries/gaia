class CreateUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :usertype
      t.string :role
      t.boolean :deleted, default: false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
