class CreateFaveTrains < ActiveRecord::Migration[5.1]
  def change
    create_table :fave_trains do |t|
      t.integer :user_id
      t.integer :train_id

      t.timestamps
    end
  end
end
