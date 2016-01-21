class StoriesController < ApplicationController

	before_action :set_story,  only: [:edit,:update]
	#impressionist actions: [:show]

	def index
		#@stories=Story.all
		@dumy = nil
		@situations = Situation.select(:situ).distinct		
		
		@stories = Story.where(ispublish: true).order("id").
      paginate(page: params[:page], per_page: 15)

	end

	def new
		@situations = Situation.select(:situ).distinct		
		@humantypes = Humantype.select(:typeindex,:content_type).distinct
		
	end

	def confirm
		@user=@current_user #users/newから入力されたデータを持ってくる
		@story=Story.new(story_params)
		# render :new if @story.invalid?
		# p @story.title+"-------------------------------------------------------"

	end

	def create
		#if params[:back]
		#	render "form"
		#else	

		#@user=User.find(params[:user_id]) #users/newから入力されたデータを持ってくる
		@user = User.find(@current_user.id) #2016/1/17
		
		@story=@user.stories.create(story_params)
		#@array=@story.story_ja.split(",") #意味なし,ビュー側でsplitしなきゃだめ
		# unless @story.errors.empty? 
		# 	puts "error 2016 ***************************"
		# end

		if @story.valid? == false
			puts "error:story create *********************#"
			@situations = Situation.select(:situ).distinct		
			@humantypes = Humantype.select(:typeindex,:content_type).distinct
			render 'new_error' 
		else

			redirect_to user_story_path(@story.user.id,@story.id)
		end
		
	end

	def destroy
		@story=Story.find(params[:id])
		@story.destroy
		redirect_to stories_path

	end

	def show
		@story=Story.find(params[:id])
		@array=@story.story_ja.split(",")
		#@situation = Situation.find_by(situindex: @story.situation)
		@humantype1 = Humantype.find_by(typeindex: @story.humantype1)
		@humantype2 = Humantype.find_by(typeindex: @story.humantype2)

        # 英訳版を作るか、それとも確認するかのリンク表示制御
		@engCreateFlag = 0
		if @story.englishcomments.empty? 
			@engCreateFlag = 1
			@flag = 0
		else
			@englishcomments = @story.englishcomments
			@engbody= Array.new
			0.upto(@englishcomments.size - 1) { |num| 
				if @englishcomments[num].ispublish == false
					@engbody << "保留"
				else
					@engbody << @englishcomments[num].body
				end
			}
			
			if @array.count > @englishcomments.size
				TermColor.green
				puts "@array.count = #{@array.count} : @englishcomments.size=#{@englishcomments.size}"	
				@diff = @array.count - @englishcomments.size
				0.upto(@diff -1){ |tempnum|
					@engbody << "英訳があれば作ってみましょう^_^"
				}
			end
			if  @array.count < @englishcomments.size
				TermColor.green
				puts "@array.count = #{@array.count} : @englishcomments.size=#{@englishcomments.size}"	
				@diff = @englishcomments.size - @array.count
				0.upto(@diff -1){ |tempnum|
					@story.englishcomments[@englishcomments.size-1-tempnum].destroy
				}
			end
			@flag = 1
		end
		
		if params[:format].present?
		@humantype=Humantype.find_by_typeindex(params[:format])
		#p @humantype.typeindex
		#p @humantype.content_type

			if @humantype.data.present?
      			send_data @humantype.data,
        		type: 'image/jpeg', disposition: "inline"
        		
				p "#{@story.impressionist_count} ------------------------------------------"
		

    		else
      			raise NotFound
			end

		else
			#impressionist(@story,nil,:unique => [:session_hash]) => ならん
			impressionist(@story)
			# 意味なし　story.pvで、index.html.erbで表示させようとしても表示されない
			
			render "stories/show"
	    end

	end

	def edit 

		@situations = Situation.select(:situ).distinct		
		@humantypes = Humantype.select(:typeindex,:content_type).distinct

	end

	def update
		TermColor.green
		# p "call story:update--------------------:ispublish = #{params[:ispublish]}----------------------------"
		p "#{params[:story][:englishcomments_attributes]}"
		p "params[:story].empty?=#{params[:story].empty?}"
		@flag = 0
		@storyUpdateFlag = 0
		@iscreateEng = false
		@isnormalUpdateFlag = 0
		if params[:story][:englishcomments_attributes] == nil
			puts "normal update"
			#英訳版を作った後でも日本語版のupdateを可能にするため
			@isnormalUpdateFlag = 1
		else
			puts "add English_ver"
			@iscreateEng = @story.update(story_english_params)
		end
		

		TermColor.green
		p "update?--------------------#{@iscreateEng}----------------------------"
		# Please note that you may only call render OR redirect, and at most once per action. 
		TermColor.green
		if @story.englishcomments.size == 0 
			
			puts "englishcomments is empty #{@story.englishcomments.size}"
		else
			puts "englishcomments exits #{@story.englishcomments.size}"
			# 注意:英訳版を作ったあとに、日本語版の編集を使用としたときもこのflagが立つ
			@flag = 1
		end

		TermColor.green
		puts "before update(story_params) -----------------"
		# 英語版なしの状態で日本語版を編集　|| 英語版がある状態から日本語版編集
		if @flag == 0  || @isnormalUpdateFlag == 1
			if @story.update(story_params) 
				TermColor.green
				puts "@story.update(story_params)"
				@storyUpdateFlag = 1
				# redirect_to user_story_path(@story.user.id,@story.id)
			else
				render 'edit'
			end
		end
		# 英語版を追加した後　|| 日本語版編週した後　=>全てshow.html.erb(storyモデルの)する
		if @storyUpdateFlag == 1 || @flag == 1 
			TermColor.green
			puts "next: redirect_to user_story_path(@story.user.id,@story.id)"
			redirect_to user_story_path(@story.user.id,@story.id)
			@storyUpdateFlag =  0
			@flag =0
		else
			TermColor.green
			puts "fainal else"
		end
	end


	def search
		#@stories=Story.where('situation =?',params[:situation])
		@stories=Story.where('situation =?',params[:situation]).paginate(page: params[:page],per_page: 15)
		#render "stories/index"
	end


	def createeng
		TermColor.green
		puts "------------called myaction ------------2015/11/21--------------------------"
		@story=Story.find(params[:story_id])
		@user=User.find(params[:user_id])
		@array=@story.story_ja.split(",")
		@count = 0
		@test = "test myaction"
		(@array.count).times {

			@story.englishcomments.build
		}
		
		# @englishcomment = @story.englishcomments.build
		#params = { test: {
		#	englishcomments_attributes:[
		#		{body: 'test1'},
		#		{body: 'test2'},
		#		{body: 'test3'},
		#		{body: '',_destroy:'1'}
		#	]
		#}}
		#@story_test = Story.create(params[:test])
		#puts "#{@story_test.englishcomments.size}"
		#puts "#{@story_test.englishcomments.first.body}"
		#puts "#{@story_test.englishcomments.second.body}"


		render "englishcomments/new"
	end
	def editeng
		TermColor.green
		puts "------------called editeng ------------2015/11/29--------------------------"
		@story=Story.find(params[:story_id])
		@user=User.find(params[:user_id])
		@array=@story.story_ja.split(",")
		@count = 0
		@englishcomments = Englishcomment.where('story_id =?',params[:story_id])
		render "englishcomments/edit"
	end

	private 
		def story_params
			#入力データのオブジェクトとユーザーネームだけ必要な場合
			params[:story].permit(:title,:situation,:humantype1,:humantype2,:story_ja,:ispublish) 
			#params.require(:story).permit(:title,:situation,:humantype1,:humantype2,:story_ja) 

		end
		
		def set_story
			@story=Story.find(params[:id])
		end

		# 2015/11/21
		def story_english_params
			params.require(:story).permit(englishcomments_attributes: [:id,:story_id,:body,:ispublish]
        )
	end

end
