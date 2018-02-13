class AddDirection < ActiveRecord::Migration[5.1]
  def change
    add_column :fave_trains, :direction, :string
  end
end
