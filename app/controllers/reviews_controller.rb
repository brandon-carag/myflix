class ReviewsController < ApplicationController
  def create
    @video=Video.find(params[:id])
    @review=@video.reviews.create(params.require(:review).permit(:body,:rating))
    @review.user=current_user

    if @review.save
      flash[:success]="Thank you for reviewing #{@video.title}."
      redirect_to video_path(@video)
    else
      flash[:danger]="There was something wrong with your review, please correct the errors and re-submit"
      redirect_to video_path(@video)
    end

  end

end
