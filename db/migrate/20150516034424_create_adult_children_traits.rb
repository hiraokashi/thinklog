class CreateAdultChildrenTraits < ActiveRecord::Migration
  def change
    create_table :adult_children_traits do |t|
      t.text :contents, null: false

      t.timestamps null: false
    end
  end
end
