class ChangeTimetoInteger < ActiveRecord::Migration[5.0]
  def change

  	remove_column :durations, :time, :time
  	add_column :durations, :length, :integer
  end
end
