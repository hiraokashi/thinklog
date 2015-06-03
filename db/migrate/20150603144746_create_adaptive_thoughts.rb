class CreateAdaptiveThoughts < ActiveRecord::Migration
  def change
    create_table :adaptive_thoughts do |t|
      t.text :contents
      t.references :automatic_thought, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
