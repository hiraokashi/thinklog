class CreateCoIndependentTraits < ActiveRecord::Migration
  def change
    create_table :co_independent_traits do |t|
      t.text :contents, null: false

      t.timestamps null: false
    end
  end
end
