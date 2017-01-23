class SynchHealthPlanHealthSystemUser < ActiveRecord::Migration[5.0]
  def change

  	rename_column :health_systems, :concierge, :virtual_visit
  	rename_column :health_plans, :pcp_copay, :pcp
  	rename_column :health_plans, :specialist_copay, :specialist
  	rename_column :health_plans, :er_copay, :er
  	rename_column :health_plans, :urgent_care_copay, :urgent_care
  	rename_column :health_plans, :co_insurance_copay, :co_insurance
  	rename_column :health_plans, :virtual_visit_copay, :virtual_visit
  	add_column :health_plans, :inpatient_copay, :integer
  	add_column :users, :deductible, :integer
  	add_column :users, :out_of_pocket_max, :integer

  end
end
