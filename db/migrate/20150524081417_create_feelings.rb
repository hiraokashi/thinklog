class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.text :contents, null: false

      t.timestamps null: false
    end
  end
end
