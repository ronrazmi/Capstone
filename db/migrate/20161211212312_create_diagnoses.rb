class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.string :ICD_code
      t.string :diagnosis_name

      t.timestamps
    end
  end
end
