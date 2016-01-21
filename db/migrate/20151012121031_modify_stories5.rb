class ModifyStories5 < ActiveRecord::Migration
  def up
  	change_column :stories,:situation,:string
  end
end
