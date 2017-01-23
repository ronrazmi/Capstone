class HealthPlanHealthSystem < ActiveRecord::Migration[5.0]
  def change

  	rename_column :health_plans, :inpatient_copay, :inpatient_deductible
  	rename_column :health_systems, :urgentcare, :urgent_care
  	add_column :health_plans, :pharmacy_clinic, :integer
  end
end
