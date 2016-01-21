class ModifyStories1 < ActiveRecord::Migration
  def up
  	#掲載時刻
  	add_column :stories,:released_at,:datetime 
  	#add_column :stories,:user_only,:boolean
  end
end
