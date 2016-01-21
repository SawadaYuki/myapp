class CreateHumantypes < ActiveRecord::Migration
  def change
    create_table :humantypes do |t|

    	t.integer :typeindex
    	t.binary :data
    	t.string :content_type

      t.timestamps null: false
    end
  end
end
