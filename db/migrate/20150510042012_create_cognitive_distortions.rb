class CreateCognitiveDistortions < ActiveRecord::Migration
  def change
    create_table :cognitive_distortions do |t|
      t.text :question
      t.text :name, null: false

      t.timestamps null: false
    end
  end
end
