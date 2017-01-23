class CreatePlanProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :plan_providers do |t|
      t.integer :health_plan_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
