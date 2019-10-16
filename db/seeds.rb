# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# before creation, make a user at ID "0"


deleted_user = User.new
deleted_user.id = 0
deleted_user.username = "previously_deleted" 
deleted_user.save
puts "Created deleted user"

users = [
{username: "Awesome Allias"},
{username: "Brilliant Banda"},
{username: "Crawfish Cartoon"},
{username: "Doris Doris?"},
{username: "Esurprise Surprise"},
{username: "Fooey the Foolish"}, 
{username: "Gorry Gorilla"}
]

users.each do |profile|
  user = User.create(profile)
end
puts "Created standard users"

works = [
{name: "Bodhizafa",
category: "movie",
description: "awesome IPA",
creator: "Georgetown",
publication_year: "2011"},

{name: "Spacedust IPA",
category: "movie",
description: "delicious IPA",
creator: "Elysian",
publication_year: "2016"}, 

{name: "Dang!",
category: "movie",
description: "sharp IPA",
creator: "Hellbent",
publication_year: "2000"},

{name: "Right One and a Half",
category: "album",
description: "From a cross body lead, from three",
creator: "Micheal",
publication_year: "2017"}, 

{name: "Hammerlock",
category: "album", 
description: "From open position, left turn holding the right", 
creator: "Momo", 
publication_year: "2018"}, 


{name: "The Martian",
category: "book", 
description: "Fear my botany powers", 
creator: "Andy Weir", 
publication_year: "2011"},


{name: "Everything's Trash but It's OK",
category: "book", 
description: "The Bachelor", 
creator: "Pheobe Robinson", 
publication_year: "2018"}
]


works.each do |profile|
  work = Work.create(profile)
end
puts "Created works"

votes = [
{user_id: 1, work_id: 1}, 
{user_id: 1, work_id: 2}, 
{user_id: 2, work_id: 5}, 
{user_id: 3, work_id: 1}, 
{user_id: 3, work_id: 2}, 
{user_id: 4, work_id: 1}, 
{user_id: 5, work_id: 4}, 
{user_id: 6, work_id: 1}
]

votes.each do |profile|
  vote = Vote.create(profile)
end
puts "Created votes"