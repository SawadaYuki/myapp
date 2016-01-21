class ModifyStories4 < ActiveRecord::Migration
  def up
  	add_column :stories, :ispublish, :boolean,defalut: false
  	add_column :stories, :pv,:integer,defalut: 0
  end
end
