class CreateEnglishcomments < ActiveRecord::Migration
  def change
    create_table :englishcomments do |t|
      t.references :story,null: false
      t.text :body
      t.boolean :ispublish,default: true 

      t.timestamps null: false
    end
  end
end
