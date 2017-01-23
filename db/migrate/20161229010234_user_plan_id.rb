class UserPlanId < ActiveRecord::Migration[5.0]
  def change

  	add_column :users, :health_plan_id, :integer
  end
end
