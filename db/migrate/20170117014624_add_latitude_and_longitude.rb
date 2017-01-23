class AddLatitudeAndLongitude < ActiveRecord::Migration[5.0]
  def change

  	add_column :users, :latitude, :float
  	add_column :users, :longitude, :float
  	add_column :providers, :latitude, :float
  	add_column :providers, :longitude, :float
  	add_column :health_systems, :latitude, :float
  	add_column :health_systems, :longitude, :float
  	
  end
end
