class VideosController < ApplicationController
  
before_action :require_login, only: [:index,:show,:search]

def index
end

def show
@video=Video.find(params[:id])
@review=Review.new
@reviews=@video.reviews
end

def search
  @search_results=Video.search_by_title(params[:search_query])
end

def play_video
  render '/shared/play_video'
end

end