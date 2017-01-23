class UserPassWordActive < ActiveRecord::Migration[5.0]
  def change

  	add_column :users, :password_digest, :string
  	add_column :users, :active, :boolean
  	drop_table :active_users
  end
end
