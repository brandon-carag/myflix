require 'spec_helper'
require 'shoulda/matchers'
require 'pry'

describe Category do

#shoulda_matchers_from_thoughtbot
it { should have_many(:videos) }

describe '# recent_videos' do

  it 'returns an empty array if there are no videos in the category' do
    test_category=Category.create(name:"Drama")
    expect(test_category.recent_videos).to eq([])
  end

  it 'returns only 6 videos if there are more than 6 videos' do
    test_category=Category.create(name:"Test Category")
    7.times do
    Video.create(title:"Test Movie",description:"Test Description",category:test_category)
    end
    expect(test_category.recent_videos.size).to eq(6)
  end

  it 'returns all of the videos if there are less than 6 videos' do
    test_category=Category.create(name:"Drama")
    5.times do
    Video.create(title:"Test Movie",description:"Test Description",category:test_category)
    end
    expect(test_category.recent_videos.size).to eq(test_category.videos.size)
  end

  it 'returns the videos from most recent to least recent' do
    test_category=Category.create(name:"Test Category")
    video1=Video.create(title:"Test Movie",description:"Test Description",category:test_category,created_at: '1/1/12')
    video2=Video.create(title:"Test Movie",description:"Test Description",category:test_category,created_at: '1/1/13')
    video3=Video.create(title:"Test Movie",description:"Test Description",category:test_category,created_at: '1/1/14')
    expect(test_category.recent_videos).to eq([video3,video2,video1])
  end

end
  
#unnecessary tests covered by rails or shoulda_matchers from thoughtbot
  # it "saves itself" do
  #   category=Category.new(name:"Test Category")
  #   category.save
  #   expect(Category.first).to eq(category)
  # end

  # it "has_many videos" do
  #   category=Category.create(name:"Test Category")
  #   video=Video.create(title:"Futurama",description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category: category)
  #   video2=Video.create(title:"Family Guy",description:"Test Descrip2",small_cover_url:"/tmp/family_guy.jpg",large_cover_url:"/tmp/family_guy.jpg",category:category)
  #   expect(category.videos).to include(video,video2)
  # end




end

