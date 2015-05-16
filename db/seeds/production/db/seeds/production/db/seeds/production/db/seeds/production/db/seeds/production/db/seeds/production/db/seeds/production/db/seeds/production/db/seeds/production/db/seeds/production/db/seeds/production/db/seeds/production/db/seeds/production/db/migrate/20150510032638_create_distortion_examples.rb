# -*- coding: utf-8 -*-
class CreateDistortionExamples < ActiveRecord::Migration
  def change
    create_table :distortion_examples do |t|
      t.references :cognitive_diagnosis, null: false
      t.string :example_contents, null: false #認知の歪みの例
      t.timestamps null: false
    end

#    add_index :blog_posts, :permalink, unique: true

    # add a foreign key to `articles.author_id` referencing `authors.id`
    #add_foreign_key :users, :authors

  end
end
