# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def delete_all_data
  arr=[Video,Category]
  arr.each{|arr_element|arr_element.delete_all}
end

categories=["TV Comedies","TV Dramas","Reality TV"]
categories.each do |category|
  Category.create(name:category)
end

Video.create(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category:Category.find_by(name: "TV Comedies"))
Video.create(title:"Family Guy",description:"Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture. -Wikipedia",small_cover_url:"/tmp/family_guy.jpg",large_cover_url:"/tmp/family_guy.jpg",category:Category.find_by(name: "TV Comedies"))
Video.create(title:"Monk",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk2",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk3",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk4",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk5",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk6",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))
Video.create(title:"Monk7",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category:Category.find_by(name: "TV Dramas"))


User.create(email:"brandon@email.com",password:"password",full_name:"Brandon Carag")