class CreateUserHealthCenters < ActiveRecord::Migration[5.0]
  def change
    create_table :user_health_systems do |t|
      t.integer :user_id
      t.integer :health_systems_id

      t.timestamps
    end
  end
end
