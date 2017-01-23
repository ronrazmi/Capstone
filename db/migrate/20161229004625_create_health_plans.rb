class CreateHealthPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :health_plans do |t|
      t.string :name
      t.integer :type_id

      t.timestamps
    end
  end
end
