class DeleteHealthPlanTypeId < ActiveRecord::Migration[5.0]
  def change
  	remove_column :health_plans, :health_plan_type_id, :integer
  end
end
