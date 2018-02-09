class AddStopToFaveTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :fave_trains, :stop, :string
  end
end
