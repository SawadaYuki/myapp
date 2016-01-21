class ModifyUsers3 < ActiveRecord::Migration
  def up
  	add_column :users,:birthday,:date
  	add_column :users,:gender,:integer,null:false,default: 0
  end
end
