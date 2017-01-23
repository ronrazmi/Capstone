class CreateUserDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_diagnoses do |t|
      t.integer :user_id
      t.integer :diagnosis_id

      t.timestamps
    end
  end
end
