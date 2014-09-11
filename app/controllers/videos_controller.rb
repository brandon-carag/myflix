class VideosController < ApplicationController;
before_action :require_login, only: [:index,:show,:search]

def index
end

def show
@video=Video.find(params[:id])
end

def search
  @search_results=Video.search_by_title(params[:search_query])
end

end