class UsersController < ApplicationController

	#before_action :set_user,  only: [:show,:edit,:update,:destroy] 元々
	before_action :set_user,  only: [:show,:destroy]
	#before_filter :login_required #application_controller.rbにて定義
	before_action :set_loginuser,only: [:edit,:update]


	def index
		@erromsg = ""
		#@users=User.all
		@users = User.order("id").
      paginate(page: params[:page], per_page: 15)

	end
	def show
		
	end
	def new
		@user=User.new
	end
	def create
		@user=User.new(user_params) #users/newから入力されたデータを持ってくる
	
		#p @user.hashed_password

		if @user.save #validation=true
		   redirect_to users_path #users/index
		else #usernameが空の場合は保存せず、users/newへ 実質_form.html.erb
		 	render 'new' 
		end

	end

	def edit
		#defaultでは if @current_user => @user=@current_user
		if(params[:id])  # action 'hint'からuser_idをもらった場合
			@user = User.find(params[:id])
		end
		
	end

	def update
		if(params[:id])  # action 'hint'経由のedit_formからuser_idをもらった場合
			@user = User.find(params[:id])
		end
		puts "username = #{@user.username}"
	 	if @current_user # ログインしてからの変更
			if @user.update(params[:user].permit(:username,:nickname,:gender,:birthday))
				redirect_to users_path
			else
				render 'edit'
			end
	 	else  # パスワード問い合わせからの変更
			if @user.update(user_params)
				redirect_to users_path
			else
				render 'edit'
			end
	 	end
	end

	def destroy
		
		@user.destroy
		redirect_to users_path #users/index
	end

    def search
		#@users=User.search(params[:q]) #searchをUserクラスのクラスメゾットとする(user.rbに記載)

		#@users=User.where('username LIKE ?',"#{params[:username]}") OK
		#@users=User.where('username =?',params[:username]) 
		@users=User.where('username =?',params[:username]).paginate(page: params[:page],per_page: 15)
		
	end

	def hint

		@erromsg = " "
		@flags=Array.new(3,1)
		@errono =Array.new(4,0) #error候補の判別をフラグで管理
		@user = User.new
		puts "#{@flags[0]}"
		puts "#{@flags[1]}"
		puts "#{@flags[2]}"
		#入力漏れのチェック
		if params[:username] == ""
			puts "params[:username]=#{params[:username]} "
			@flags[0] = 0
		end
		if params[:nickname] == ""
			puts "params[:nickname]=#{params[:nickname]} "
			@flags[1] = 0
		end
		if params[:birthday] == ""
			puts "params[:birthday]=#{params[:birthday]} "
			puts "params[:birthday]=#{params[:birthday].class}"	
			@flags[2] = 0
		end

		#入力漏れがない場合
		puts "@flags.include?(0) = #{@flags.include?(0)}"
		if @flags.include?(0) == false
			@dateArray=params[:birthday].split("-")
			0.upto(@dateArray.size-1){ |num|
				puts "@dateArray[#{num}]=#{@dateArray[num]}:#{@dateArray[num].class}"
				@integerVer = @dateArray[num].to_i
				@dateArray[num] = @integerVer
				puts "change:@dateArray[#{num}]=#{@dateArray[num]}:#{@dateArray[num].class}"
			}
			@date = Date.new(@dateArray[0],@dateArray[1],@dateArray[2])
			puts "@date=#{@date}"
			#@user=User.where('nickname =?',params[:nickname]) # <---なぜか知らんがこれだとうまくいかにあ
			#@user=User.find_by(nickname: params[:nickname])
			@flag = false
			unless User.find_by(nickname: params[:nickname]) == nil
				@user=User.find_by(nickname: params[:nickname])
				puts "@user.nickname = #{@user.nickname}"
				puts "@user.username = #{@user.username} "
				puts "user_id = #{@user.id} "
				puts "user.birthday = #{@user.birthday} "
				if @user.username == params[:username] #なおかつusernameもあっている
					@flag = true
				else
					@errono[1] = 1
				end
			else 
				puts "nickname is not exist" # => @user = nil
				@errono[0] = 1
			end
			
			puts "#{ @user.birthday == params[:birthday]}"
			puts "@flag = #{@flag}"
			if @flag == true && @user.birthday == @date # userが存在し,nickname と生年月日が正しい

				redirect_to edit_user_path(@user.id) # -> passwordの再設定を許可する

			else
				
				if @errono[0] == 0 && (@user.birthday == @date) == false 
					@errono[2] = 1
					puts "birthday is wrong"
				end
				#@erromsg = "reinput"
				# render 'index'
			end

		else # 入力漏れがある
			@errono[3] = 1
			#@erromsg = "reinput"

		end	#else

		puts "errno[0] =#{@errono[0]}"
		puts "errno[1] =#{@errono[1]}"
		puts "errno[2] =#{@errono[2]}"
		puts "errno[3] =#{@errono[3]}"

		if @errono.include?(1)
			if @errono[0] == 1
				@erromsg << "error(1)ニックネームが間違っています "
			end
			if @errono[1] ==1
				@erromsg << "error(2)ニックネームは該当しますが,ユーザーネームが間違っています "
			end
			if @errono[2] == 1
				@erromsg << "error(3)ニックネームは該当しますが,生年月日が間違っています "
			end
			if @errono[3] == 1
				@erromsg << "error(4)入力漏れがあります "
			end
			#@erromsg= @erromsg.split(' ')
			render 'index'
		end
		
	end #hint

	private 
		def user_params
			#入力データのオブジェクトとユーザーネームだけ必要な場合
			params[:user].permit(:username,:nickname,:password, :password_confirmation,:gender,:birthday,:administrator)
		end

		def set_user
			@user=User.find(params[:id])
		end

		def set_loginuser
			if @current_user
				@user=@current_user
		    end
		end

	
	
end
