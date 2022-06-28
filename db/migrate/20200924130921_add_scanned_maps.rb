class AddScannedMaps < ActiveRecord::Migration[5.1]
  def change
    add_column :data_requests, :scanned_maps, :text
  end
end
