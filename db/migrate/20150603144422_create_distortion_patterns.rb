class CreateDistortionPatterns < ActiveRecord::Migration
  def change
    create_table :distortion_patterns do |t|
      t.references :cognitive_distortion, index: true, foreign_key: true
      t.string :distortion_pattern

      t.timestamps null: false
    end
  end
end
