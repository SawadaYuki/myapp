class User < ActiveRecord::Base
	has_many :stories
	#presence: あるかどうか
	#usenameが空の場合、保存しない
	validates :username, presence: true, length: {minimum:3,message: "短い"},uniqueness: true
    validates :nickname, presence: true, uniqueness: true
	#エラーメッセージを変えたいとき↓
	#validates :username, presence: {message: "usernameが空です"}

	#userモデル作成時に入力を必要とし,パスワードの確認をする
	validates :password, presence: { on: :create },confirmation: { allow_blank: true }



	attr_accessor :password, :password_confirmation

	# ACCESSIBLE_ATTRSに一般会員が使える属性を並べ、attr_accessibleメゾットに渡す
	# as: :adminオプションをつけたattr_accessibleメゾットには指定した属性を加えた配列を渡す
	#ACCESSIBLE_ATTRS = [ :username, :nickname, :password, :password_confirmation ]
  #attr_accessible *ACCESSIBLE_ATTRS
  #attr_accessible *(ACCESSIBLE_ATTRS + [:administrator]), as: :admin



#書き込み用アクせサメゾット
	def password=(val)
		
		if val.present?
		#BCrypt::password.create(val)で暗号化されたパスワードを作成
			self.hashed_password = BCrypt::Password.create(val)
		end
		@password=val
		
	end
#private
	class << self
	 def authenticate(username,password)
		#usernameのuserモデルを取り出し
		user = User.find_by_username(username)
		#userのhashed_passwordをBCrypt::password.newに渡した結果が引数
		#のパスワードと一致すればモデルオブジェクトを返す
		if user && user.hashed_password.present? && BCrypt::Password.new(user.hashed_password) == password
			user
		else
			nil
		end
	 end	
	end
end
