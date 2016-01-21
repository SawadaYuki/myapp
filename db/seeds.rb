# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




#db/seeds/環境/以下にテーブル名.rbファイルがあればそれをrequireメゾットで実行する
table_names = %w(users humantypes situations)
table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end


#0.upto(2) do |idx| 
#fname=Rails.root.join("db/seeds/development","member#{idx%3+1}.jpg")
#Human_type.create(
#{
#	data: File.open(fname,"rb").read,
#	content_type: "image/jpeg"
#},without_protection: true)
#end