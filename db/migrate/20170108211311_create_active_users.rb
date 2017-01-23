  class CreateActiveUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :active_users do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :age
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :password_digest
      t.string :health_plan_id

      t.timestamps
    end
  end
end
