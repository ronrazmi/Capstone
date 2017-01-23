class HealthPlanCoInsurance < ActiveRecord::Migration[5.0]
  def change

  	change_column :health_plans, :co_insurance, :float 
  end
end
