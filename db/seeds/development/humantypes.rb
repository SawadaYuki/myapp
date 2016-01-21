
fname=Rails.root.join("db/seeds/development","member1.jpg")
Humantype.create(

	typeindex: 1,
	data: File.open(fname,"rb").read,
	content_type: "I"
)


fname=Rails.root.join("db/seeds/development","member2.jpg")
Humantype.create(
	typeindex: 2,
	data: File.open(fname,"rb").read,
	content_type: "friend"
)

fname=Rails.root.join("db/seeds/development","member3.jpg")
Humantype.create(
	typeindex: 3,
	data: File.open(fname,"rb").read,
	content_type: "teacher"
)

