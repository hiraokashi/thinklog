class CreateSituations < ActiveRecord::Migration
  def change
    create_table :situations do |t|
      t.text :when
      t.text :where
      t.text :with_whom
      t.text :what_have_you_been_doing
      t.string :occured_time #yyyymmddhhMMss で保存。いろいろ自分で制御したいので
      t.integer :mood_status
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
