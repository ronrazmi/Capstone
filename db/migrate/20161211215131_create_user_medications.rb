class CreateUserMedications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_medications do |t|
      t.integer :medication_id
      t.integer :user_id

      t.timestamps
    end
  end
end
