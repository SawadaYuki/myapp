class Admin::StoriesController < Admin::Base

	before_action :set_story,  only: [:edit,:update]

	def index
		@stories=Story.all

	end

	def new
	end

	def create
		@user=User.find(params[:user_id]) #users/newから入力されたデータを持ってくる
		@story=@user.stories.create(story_params)
		#@array=@story.story_ja.split(",") #意味なし,ビュー側でsplitしなきゃだめ

		redirect_to new_admin_story_path,notice: "英会話を作成しました"
		#render 'pre_create'	
	end

	def destroy
		@story=Story.find(params[:id])
		@story.destroy
		redirect_to admin_stories_path(params[:user_id])

	end

	def show
		@story=Story.find(params[:id])
		@array=@story.story_ja.split(",")
		#render "list"

	end
	def edit 

	end
	def update
		
		if @story.update(story_params)
			redirect_to admin_stories_path,notice: "英会話を更新しました"
		else
			render 'edit'
		end
	end


	private 
		def story_params
			#入力データのオブジェクトとユーザーネームだけ必要な場合
			params[:story].permit(:title,:situation,:humantype1,:story_ja) 
			#params[:story].permit(:title,:situation,:humantype1,:humantype2)
		end
		
		def set_story
			@story=Story.find(params[:id])
		end
end
