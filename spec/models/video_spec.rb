require 'spec_helper'

describe Video do
  it "saves itself" do
    video=Video.new(title:"Futurama",description:"Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999. -IMDB",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:1)
    video.save
    # Old Test Syntax
    # Video.first.title.should=="Futurama"
    expect(Video.first).to eq(video)
    end

  it "belongs_to category" do
    category=Category.create(name:"Test Category")
    video=Video.create(title:"Futurama",description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category: category)
    expect(video.category).to eq(category)
  end

  it "validates_presence_of :title" do
    video=Video.create(description:"Test Descrip",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id: 2)
    expect(Video.all.size).to eq(0) || expect(video.errors.any?)==true
  end

  it "validates_presence_of :description" do
    video=Video.create(title:"Futurama",small_cover_url:"/tmp/futurama.jpg",large_cover_url:"/tmp/futurama.jpg",category_id:2)
    expect(Video.all.size).to eq(0) || expect(video.errors.any?)==true
  end


end