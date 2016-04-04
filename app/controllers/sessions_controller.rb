class SessionsController < ApplicationController
	def create 
		

		user=User.authenticate(params[:nickname],params[:password])
		if(user != nil)
			puts "After User.auth~:#{user.nickname}:#{params[:from]}:#{:root}:#{params[:from] || :root}"
		end
		puts "#{params[:from].class}"

		if user
			session[:user_id]=user.id
		else
			flash.alert="名前とパスワードが一致しません"
		end
		if params[:from] == "/users/hint"
			params[:from]="/"
			puts "change path:#{params[:from]}"
		end
		redirect_to params[:from] || :root
	end

	def destroy
		session.delete(:user_id)
		redirect_to :root
	end
end
