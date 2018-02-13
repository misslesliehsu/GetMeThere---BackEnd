class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :regular
      t.string :coded

      t.timestamps
    end
  end
end
