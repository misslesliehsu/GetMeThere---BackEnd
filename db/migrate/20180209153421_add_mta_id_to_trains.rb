class AddMtaIdToTrains < ActiveRecord::Migration[5.1]
  def change
    add_column :trains, :Mta_Id, :integer
  end
end
