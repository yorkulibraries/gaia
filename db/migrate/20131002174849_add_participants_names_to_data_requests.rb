class AddParticipantsNamesToDataRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :data_requests, :participants_names, :text
  end
end
