class Admin::VideosController < AdminController 

def new
  @video = Video.new
end

def create
  @video = Video.new(params.require(:video).permit(:title,:description,:category_id,:small_cover_url,:large_cover_url,:image,:video_url))

  if @video.save
    flash[:success] = "The video was successfully saved to the database"
    redirect_to new_admin_video_path
  else
    flash[:danger] = "There was an error while trying to save the video to the database.  Please try again."
    render 'new'
  end
end

end