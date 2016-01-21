class ModifyStories2 < ActiveRecord::Migration
  def up
  	add_column :stories,:user_only,:boolean
  end
end
