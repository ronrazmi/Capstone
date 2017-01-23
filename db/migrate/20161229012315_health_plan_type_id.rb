class HealthPlanTypeId < ActiveRecord::Migration[5.0]
  def change

  	rename_column :health_plans, :type_id, :health_plan_type_id
  end
end
