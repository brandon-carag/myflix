require 'spec_helper'
require 'pry'

describe Category do
  
  it "saves itself" do
    category=Category.new(name:"Test Category")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has_many videos" do
    category=Category.create(name:"Test Category")
    video=Video.create(title:"Futurama",description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category: category)
    video2=Video.create(title:"Family Guy",description:"Test Descrip2",small_cover_url:"/tmp/family_guy.jpg",large_cover_url:"/tmp/family_guy.jpg",category:category)
    expect(category.videos).to include(video,video2)
  end

end

