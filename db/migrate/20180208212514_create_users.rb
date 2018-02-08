class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :fave_location_1
      t.string :fave_location_2
      t.string :fave_location_3
      t.string :fave_search_1
      t.string :fave_search_2
      t.string :fave_search_3

      t.timestamps
    end
  end
end
