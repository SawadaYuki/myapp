class CreateSituations < ActiveRecord::Migration
  def change
    create_table :situations do |t|
      t.integer :situindex
      t.string :situ

      t.timestamps null: false
    end
  end
end
