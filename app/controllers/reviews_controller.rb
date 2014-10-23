class ReviewsController < ApplicationController
before_action :require_login, only: [:create]

  def create
    @video=Video.find(params[:id])
    @review=@video.reviews.new(params.require(:review).permit(:body,:rating))
    @review.user=current_user

    if @review.save
      flash[:success]="Thank you for reviewing #{@video.title}."
      redirect_to video_path(@video)
    else
      flash[:danger]="There was something wrong with your review submission.  You can only review a video once."
      render 'videos/show'
      # redirect_to video_path(@video)
    end

  end

end
