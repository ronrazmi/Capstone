class CreateHealthPlanTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :health_plan_types do |t|
      t.string :name
      t.integer :deductible
      t.integer :virtual_visit_copay
      t.integer :pcp_copay
      t.integer :specialist_copay
      t.integer :er_copay
      t.integer :urgent_care_copay
      t.integer :co_insurance_copay
      t.integer :out_of_pocket_max

      t.timestamps
    end
  end
end
