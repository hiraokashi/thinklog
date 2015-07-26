class CreateGivenTimeFeelings < ActiveRecord::Migration
  def change
    create_table :given_time_feelings do |t|
      t.references :feeling, index: true, foreign_key: true
      t.references :situation, index: true, foreign_key: true
      t.integer :step1_percentage
      t.integer :step2_percentage
      t.integer :step3_percentage
      t.integer :step4_percentage
      t.integer :status, :null => false, :default => 0
      t.timestamps null: false
    end
  end
end
