class ModifyUsers2 < ActiveRecord::Migration
	# 9/30 
  def up
  	add_column :users,:administrator,:boolean, null: false,default:false
  end
end
