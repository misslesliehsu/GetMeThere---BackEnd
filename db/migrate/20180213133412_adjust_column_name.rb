class AdjustColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :fave_trains, :stop, :station_id
  end
end
