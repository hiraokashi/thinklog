class CreateAutomaticThoughts < ActiveRecord::Migration
  def change
    create_table :automatic_thoughts do |t|
      t.text :contents
      t.references :given_time_feeling, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
