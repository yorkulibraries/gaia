class AddScannedMaps < ActiveRecord::Migration
  def change
    add_column :data_requests, :scanned_maps, :text
  end
end
