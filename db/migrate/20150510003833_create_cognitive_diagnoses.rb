class CreateCognitiveDiagnoses < ActiveRecord::Migration
  def change
    create_table :cognitive_diagnoses do |t|

      t.timestamps null: false
    end
  end
end
