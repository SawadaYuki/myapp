User.create(
	username: "administrator",
	nickname: "管理人",
	password: 48694062,                  # 数字意外だめっぽい
	password_confirmation: 48694062,
	administrator: true,
	birthday: "1992-05-01",
	gender: 1
)

User.create(
	username: "test",
	nickname: "test",
	password: 123,
	password_confirmation: 123,
	administrator: false,
	birthday: "1992-05-01",
	gender: 1
)