class RemoveHealthPlanTypeTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :health_plan_types 
  end
end
