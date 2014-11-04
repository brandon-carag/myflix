# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def delete_all_data
  arr=[Video,Category,QueueItem,Review]
  arr.each{|arr_element|arr_element.delete_all}
end

def fabricate_reviews
  Video.all.each do |video| 
    10.times do
      Fabricate(:review,video_id:video.id)
    end
  end
end

def populate_categories
  categories=["Indie Films","Action/Adventure","Drama"]
  categories.each do |category|
    Category.create(name:category)
  end
end

def populate_movies
#Indie Films
Video.create(title:"Ain't Them Bodies Saints",description:"The tale of an outlaw who escapes from prison and sets out across the Texas hills to reunite with his wife and the daughter he has never met. -IMDB",small_cover_url:"/tmp/aint_them_bodies_saints.jpg",large_cover_url:"/tmp/aint_them_bodies_saints_large.jpg",category:Category.find_by(name: "Indie Films"))
Video.create(title:"The Assasination of Jesse James",description:"Robert Ford, who's idolized Jesse James since childhood, tries hard to join the reforming gang of the Missouri outlaw, but gradually becomes resentful of the bandit leader. -IMDB",small_cover_url:"/tmp/assassination_of_jesse_james.jpg",large_cover_url:"/tmp/assassination_of_jesse_james_large.jpg",category:Category.find_by(name: "Indie Films"))
Video.create(title:"The Thin Red Line",description:"Terrence Malick's adaptation of James Jones' autobiographical 1962 novel, focusing on the conflict at Guadalcanal during the second World War. -IMDB",small_cover_url:"/tmp/thin_red_line.jpg",large_cover_url:"/tmp/thin_red_line_large.jpg",category:Category.find_by(name: "Indie Films"))
Video.create(title:"The Tree of Life",description:"The story of a family in Waco, Texas in 1956. The eldest son witnesses the loss of innocence and struggles with his parents' conflicting teachings. -IMDB",small_cover_url:"/tmp/tree_of_life.jpg",large_cover_url:"/tmp/tree_of_life_large.jpg",category:Category.find_by(name: "Indie Films"))
Video.create(title:"Her",description:"A lonely writer develops an unlikely relationship with his newly purchased operating system that's designed to meet his every need. -IMDB",small_cover_url:"/tmp/her.jpg",large_cover_url:"/tmp/her_large.jpg",category:Category.find_by(name: "Indie Films"))
Video.create(title:"Eternal Sunshine of the Spotless Mind",description:"A couple undergo a procedure to erase each other from their memories when their relationship turns sour, but it is only through the process of loss that they discover what they had to begin with. -IMDB",small_cover_url:"/tmp/eternal_sunshine_of_the_spotless_mind.jpg",large_cover_url:"/tmp/eternal_sunshine_of_the_spotless_mind_large.jpg",category:Category.find_by(name: "Indie Films"))

#Action/Adventure
Video.create(title:"The Dark Knight Rises",description:"A new menace emerges and the Dark Knight rises again to protect the city from a merciless terrorist with the help of anti-heroine Selina Kyle. -IMDB",small_cover_url:"/tmp/dark_knight_rises.jpg",large_cover_url:"/tmp/dark_knight_rises_large.jpg",category:Category.find_by(name: "Action/Adventure"))
Video.create(title:"Kingdom of Heaven",description:"Balian of Ibelin travels to Jerusalem during the crusades of the 12th century, and there he finds himself as the defender of the city and its people. -IMDB",small_cover_url:"/tmp/kingdom_of_heaven.jpg",large_cover_url:"/tmp/kingdom_of_heaven_large.jpg",category:Category.find_by(name: "Action/Adventure"))
Video.create(title:"The Dark Knight",description:"When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level. -IMDB",small_cover_url:"/tmp/dark_knight.jpg",large_cover_url:"/tmp/dark_knight_large.jpg",category:Category.find_by(name: "Action/Adventure"))
Video.create(title:"The Man from Nowhere",description:"A quiet pawnshop keeper with a violent past takes on a drug- and organ trafficking ring in hope of saving the child who is his only friend. -IMDB",small_cover_url:"/tmp/man_from_nowhere.jpg",large_cover_url:"/tmp/man_from_nowhere_large.jpg",category:Category.find_by(name: "Action/Adventure"))
Video.create(title:"The Hurt Locker",description:"During the Iraq War, a Sergeant recently assigned to an army bomb squad is put at at odds with his squad mates due to his maverick way of handling his work. -IMDB",small_cover_url:"/tmp/hurt_locker.jpg",large_cover_url:"/tmp/hurt_locker_large.jpg",category:Category.find_by(name: "Action/Adventure"))
Video.create(title:"Looper",description:"In 2074, when the mob wants to get rid of someone, the target is sent into the past, where a hired gun awaits - someone like Joe - who one day learns the mob wants to 'close the loop' by sending back Joe's future self for assassination. -IMDB",small_cover_url:"/tmp/looper.jpg",large_cover_url:"/tmp/looper_large.jpg",category:Category.find_by(name: "Action/Adventure"))

#Drama
Video.create(title:"Casablanca",description:"Set in unoccupied Africa during the early days of World War II: An American expatriate meets a former lover, with unforeseen complications. -IMDB",small_cover_url:"/tmp/casablanca.jpg",large_cover_url:"/tmp/casablanca_large.jpg",category:Category.find_by(name: "Drama"))
Video.create(title:"Shadowlands",description:"Noted author and scholar finds love, then must endure its loss... -IMDB",small_cover_url:"/tmp/shadowlands.jpg",large_cover_url:"/tmp/shadowlands_large.jpg",category:Category.find_by(name: "Drama"))
Video.create(title:"500 Days of Summer",description:"An offbeat romantic comedy about a woman who doesn't believe true love exists, and the young man who falls for her. -IMDB",small_cover_url:"/tmp/500_days_of_summer.jpg",large_cover_url:"/tmp/500_days_of_summer_large.jpg",category:Category.find_by(name: "Drama"))
Video.create(title:"Legends of the Fall",description:"Epic tale of three brothers and their father living in the remote wilderness of 1900s USA and how their lives are affected by nature, history, war, and love. -IMDB",small_cover_url:"/tmp/legends_of_the_fall.jpg",large_cover_url:"/tmp/legends_of_the_fall_large.jpg",category:Category.find_by(name: "Drama"))
Video.create(title:"Open Range",description:"A former gunslinger is forced to take up arms again when he and his cattle crew are threatened by a corrupt lawman. -IMDB",small_cover_url:"/tmp/open_range.jpg",large_cover_url:"/tmp/open_range_large.jpg",category:Category.find_by(name: "Drama"))
Video.create(title:"Inception",description:"A thief who steals corporate secrets through use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO. -IMDB",small_cover_url:"/tmp/inception.jpg",large_cover_url:"/tmp/inception_large.jpg",category:Category.find_by(name: "Drama"))

end

def add_default_video_urls
  Video.all.each {|video| video.update_attributes(video_url:"https://s3-us-west-1.amazonaws.com/myflixvideos/countdown_reel.mp4")}
end

def create_users
User.create(email:"brandon@email.com",password:"password",full_name:"Brandon Carag")
end

delete_all_data
create_users
populate_categories
populate_movies
add_default_video_urls
fabricate_reviews
