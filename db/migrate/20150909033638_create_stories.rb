class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :situation
      t.string :humantype1,default: "私"
      t.string :humantype2,default: "友人"
      t.text :story_ja
      t.text :story_en
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
