class ModifyStories < ActiveRecord::Migration
  def up
  	change_column :stories, :situation, :integer
  	change_column :stories, :humantype1, :integer
  	change_column :stories, :humantype2, :integer
  end



end
