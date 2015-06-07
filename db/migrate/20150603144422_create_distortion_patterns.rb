class CreateDistortionPatterns < ActiveRecord::Migration
  def change
    create_table :distortion_patterns do |t|
      t.references :cognitive_distortion, index: true, foreign_key: true
      t.references :automatic_thought, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
