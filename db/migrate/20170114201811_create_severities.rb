class CreateSeverities < ActiveRecord::Migration[5.0]
  def change
    create_table :severities do |t|
      t.integer :intensity

      t.timestamps
    end
  end
end
