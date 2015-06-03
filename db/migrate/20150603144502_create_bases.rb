class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.text :contents
      t.references :automatic_thought, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
