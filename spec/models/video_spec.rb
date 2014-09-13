require 'spec_helper'
require 'shoulda/matchers'

describe Video do

#shoulda_matchers_from_thoughtbot
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

#.search_by_title tests

describe '.search_by_title' do

  it "returns empty array if no match" do
    futurama=Video.create(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    family_guy=Video.create(title:"Family Guy",description:"Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture. -Wikipedia",small_cover_url:"/tmp/family_guy.jpg",large_cover_url:"/tmp/family_guy.jpg",category_id:1)
    monk=Video.create(title:"Monk",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category_id:2)
    expect(Video.search_by_title("Zebra")).to eq([])
  end

  it "returns nothing for empty string" do
    futurama=Video.create(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    expect(Video.search_by_title("")).to eq([])
  end

  it "finds an exact match" do
    futurama=Video.create(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    family_guy=Video.create(title:"Family Guy",description:"Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture. -Wikipedia",small_cover_url:"/tmp/family_guy.jpg",large_cover_url:"/tmp/family_guy.jpg",category_id:1)
    monk=Video.create(title:"Monk",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category_id:2)
    expect(Video.search_by_title("Monk")).to eq([monk])
    # expect(Video.search_by_title("Monk")).to include(monk)
  end

  it "finds multiple records with partial search" do
    futurama=Video.create(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    futurama2=Video.create(title:"My title has Futurama in it",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    monk=Video.create(title:"Monk",description:"The exploits of a detective with a unique case of obsessive compulsive disorder",small_cover_url:"/tmp/monk.jpg",large_cover_url:"/tmp/monk_large.jpg",category_id:2)
    expect(Video.search_by_title("uturama")).to include(futurama,futurama2)
  end

end

describe '.avg_rating' do
  it "returns message if no reviews" do
    video=Fabricate(:video)
    # user=Fabricate(:user)
    # user2=Fabricate(:user)
    # user3=Fabricate(:user)
    expect(video.avg_rating).to eq("Not reviewed")
  end

  it "returns one decimal digit" do
    video=Fabricate(:video)
    user=Fabricate(:user)
    user2=Fabricate(:user)
    user3=Fabricate(:user)
    review1=Review.create(body:"text",rating:3,video_id:video.id,user_id:user.id)
    review2=Review.create(body:"text",rating:3,video_id:video.id,user_id:user2.id)
    review3=Review.create(body:"text",rating:1,video_id:video.id,user_id:user3.id)
    expect(video.avg_rating).to eq(2.3)
  end

end


#================================================================================================
#unnecessary tests covered by rails or shoulda_matchers from thoughtbot
  # it "saves itself" do
  #   video=Video.new(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
  #   video.save
  #   # Old Test Syntax
  #   # Video.first.title.should=="Futurama"
  #   expect(Video.first).to eq(video)
  #   end

  # it "belongs_to category" do
  #   category=Category.create(name:"Test Category")
  #   video=Video.create(title:"Futurama",description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category: category)
  #   expect(video.category).to eq(category)
  # end

  # it "validates_presence_of :title" do
  #   video=Video.create(description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id: 2)
  #   expect(Video.all.size).to eq(0) || expect(video.errors.any?)==true
  # end

  # it "validates_presence_of :description" do
  #   video=Video.create(title:"Futurama",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:2)
  #   expect(Video.all.size).to eq(0) || expect(video.errors.any?)==true
  # end

end