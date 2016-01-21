class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception 元々
  protect_from_forgery 

  class Forbidden < StandardError; end

 #セッションデータを調べてログイン状態を保持するための機能

 #authorizeメゾットでセッションデータuser_idを調べ,そのIDを持つモデルオブジェクト
 #を取り出して,インスタンス変数@current_userにいれる
 before_filter :authorize #,:rss_get
 #before_action :detect_locale

 # sawada original class
 class TermColor
  class << self
    # 色を解除
    def reset   ; c 0 ; end 

    # 各色
    def red     ; c 31; end 
    def green   ; c 32; end 
    def yellow  ; c 33; end 
    def blue    ; c 34; end 
    def magenta ; c 35; end 
    def cyan    ; c 36; end 
    def white   ; c 37; end

    # カラーシーケンスを出力する
    def c(num)
      print "\e[#{num.to_s}m"
    end 
  end 
end



private
 #全てのコントローラーの全てのアクションで@current_userの有無によってログインして
 #いるかどうかを判別
 def authorize
 	if session[:user_id]
 		@current_user=User.find_by_id(session[:user_id])
 		session.delete(:user_id) unless @current_user

 			
 	end
 end

# def rss_get
 #		url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/sf=143462/limit=10/xml"
#		url = ARGV.shift if ARGV.length &gt; 0
#		page = open(url) 
#		@rss = SimpleRSS.parse(page)
#end

 def login_required
    raise Forbidden unless @current_member #ログイン状態でないとForbiddenを発生させる
 end

 

 #def detect_locale
 #	I18n.locale = request.headers['Accept-Language'].scan(/¥A[a-z]{2}/).first
 #end


end
