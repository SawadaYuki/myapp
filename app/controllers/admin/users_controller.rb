class Admin::UsersController < Admin::Base

	before_action :set_user,  only: [:show,:edit,:update,:destroy]
	#before_filter :login_required #application_controller.rbにて定義


	def index
		@users=User.all
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
		   redirect_to admin_users_path,notice: "会員を登録しました" #users/index
		else #usernameが空の場合は保存せず、users/newへ 実質_form.html.erb
		 	render 'new' 
		end

	end

	def edit
		
	end

	def update
		
		if @user.update(user_params)
			redirect_to admin_users_path,notice: "会員情報を更新しました"
		else
			render 'edit'
		end
	end

	def destroy
		
		@user.destroy
		redirect_to admin_users_path,notice: "会員を削除しました" #users/index
	end

    def search
		#@users=User.search(params[:q]) #searchをUserクラスのクラスメゾットとする(user.rbに記載)

		#@users=User.where('username LIKE ?',"#{params[:username]}") OK
		@users=User.where('username =?',params[:username])
		#@searchword=params[:username]
	end

	private 
		def user_params
			#入力データのオブジェクトとユーザーネームだけ必要な場合
			params[:user].permit(:username,:nickname,:password, :password_confirmation
)
		end

		def set_user
			@user=User.find(params[:id])
		end

	
	
end
