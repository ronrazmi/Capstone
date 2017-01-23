class HealthSystemId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :providers, :health_center_id, :health_system_id
  	rename_column :user_health_systems, :health_systems_id, :health_system_id
  end
end
