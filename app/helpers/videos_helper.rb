module VideosHelper

  def show_small_cover_image(video)
    # if video.image_url.nil? ? image_tag(video.image_url(:small_cover) : video.small_cover_url
    if video.image_url.nil?
      link_to video_path(video) do
        image_tag(video.image_url(:small_cover))
      end

    else 
      video.small_cover_url
    end
  end

end
