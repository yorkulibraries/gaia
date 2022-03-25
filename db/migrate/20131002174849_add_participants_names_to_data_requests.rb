class AddParticipantsNamesToDataRequests < ActiveRecord::Migration
  def change
    add_column :data_requests, :participants_names, :text
  end
end
