class UsersController < ApplicationController

	#before_action :set_user,  only: [:show,:edit,:update,:destroy] 元々
	before_action :set_user,  only: [:show,:destroy]
	#before_filter :login_required #application_controller.rbにて定義
	before_action :set_loginuser,only: [:edit,:update]


	def index
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
		
	end

	def update
	 if @current_user
		if @user.update(params[:user].permit(:username,:nickname,:gender,:birthday))
			redirect_to users_path
		else
			render 'edit'
		end
	 else
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
