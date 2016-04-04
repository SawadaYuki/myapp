
fname=Rails.root.join("db/seeds/development","member1.jpg")
Humantype.create(

	typeindex: 1,
	data: File.open(fname,"rb").read,
	content_type: "私(I)"
)


fname=Rails.root.join("db/seeds/development","member2.jpg")
Humantype.create(
	typeindex: 2,
	data: File.open(fname,"rb").read,
	content_type: "友人(friend)"
)

fname=Rails.root.join("db/seeds/development","member3.jpg")
Humantype.create(
	typeindex: 3,
	data: File.open(fname,"rb").read,
	content_type: "恋人(Lover)"
)

fname=Rails.root.join("db/seeds/development","member4.jpg")
Humantype.create(
	typeindex: 4,
	data: File.open(fname,"rb").read,
	content_type: "美人(Beautiful woman just met)"
)

fname=Rails.root.join("db/seeds/development","member5.jpg")
Humantype.create(
	typeindex: 5,
	data: File.open(fname,"rb").read,
	content_type: "店員(Clerk)"
)

fname=Rails.root.join("db/seeds/development","member6.jpg")
Humantype.create(
	typeindex: 6,
	data: File.open(fname,"rb").read,
	content_type: "上司(Boss)"
)


