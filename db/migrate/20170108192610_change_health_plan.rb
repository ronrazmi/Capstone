class ChangeHealthPlan < ActiveRecord::Migration[5.0]
  def change
  	add_column :health_plans, :deductible, :integer
  	add_column :health_plans, :virtual_visit_copay, :integer
  	add_column :health_plans, :pcp_copay, :integer
  	add_column :health_plans, :specialist_copay, :integer
  	add_column :health_plans, :er_copay, :integer
  	add_column :health_plans, :urgent_care_copay, :integer
  	add_column :health_plans, :co_insurance_copay, :integer
  	add_column :health_plans, :out_of_pocket_max, :integer
  end
end
