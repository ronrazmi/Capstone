class AddNurseToUser < ActiveRecord::Migration[5.0]
  def change

  	add_column :users, :nurse_navigator, :boolean, default: false
  end
end
