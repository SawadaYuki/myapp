class EnglishcommentsController < ApplicationController
	def index
		@story=Story.find(params[:story_id])
		@test = "englishcomment:index"
		@count = 0
		@array=@story.story_ja.split(",")
		@englishcomments = Englishcomment.where('story_id =?',params[:story_id])

	end
	def new # 使わない
		@story=Story.find(params[:story_id])
		@user=User.find(params[:user_id])
		@array=@story.story_ja.split(",")
		@count = 0
		(@array.count).times {

			@story.englishcomments.build
		}
	end
	def create # 使わない
		@story=Stroy.find(params[:story_id]) #users/newから入力されたデータを持ってくる
		@array=@story.story_ja.split(",")
		(@array.count).times {
			@story.englishcomments.create(story_params)
		}
		if @story.update(story_english_params)
			p "sucess update---------------------------------------------"
			redirect_to user_story_path(@story.user.id,@story.id)
		else
			p "failed update---------------------------------------------"
			render "englishcomments/new"
		end
		#redirect_to user_story_path(@story.user.id,@story.id)
	end


	private

    def story_english_params
			params.require(:story).permit(englishcomments_attributes: [:id,:story_id,:body,:_destroy]
        )
	end
	def story_params
		#入力データのオブジェクトとユーザーネームだけ必要な場合
		params[:englishcomment].permit(:englishcomment_id,:body) 


	end

end
