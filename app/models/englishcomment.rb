class Englishcomment < ActiveRecord::Base
	belongs_to :story,foreign_key: "story_id"
	#validates :body, presence:true
	#attr_accessible :body
	
end
