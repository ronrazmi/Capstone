class CreateHealthSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :health_systems do |t|
      t.string :name
      t.string :address
      t.boolean :er
      t.boolean :urgentcare
      t.boolean :pharmacy_clinic
      t.boolean :walk_in_clinic
      t.boolean :concierge

      t.timestamps
    end
  end
end
