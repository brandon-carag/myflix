class QueueItemsController < ApplicationController
  before_action :require_login, only: [:index,:create,:destroy,:update_queue]

  def update_queue 
  begin
    update_review_ratings
    update_queue_item_list_order 
    rescue
    flash[:danger]="Invalid list order values.  Please use unique, whole numbers."
  end
  current_user.renumber_queue_item_list_order
  

  redirect_to queue_items_path

  end

  def index
    @queue_items=current_user.queue_items
    video_ids = @queue_items.map(&:video_id)
    @videos = Video.where(id:video_ids)
  end

  def create
    @queue_item=QueueItem.new(params.require(:queue_item).permit(:video_id,:user_id))
    @queue_item.update(list_order:current_user.queue_items.count+1)
    
    if @queue_item.save
      redirect_to queue_items_path 
    else
      redirect_to video_path(@queue_item.video)
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if queue_item.user.id == current_user.id
    current_user.renumber_queue_item_list_order
    redirect_to queue_items_path

  end
#==============================
  private

  def update_review_ratings
    ActiveRecord::Base.transaction do 
    params[:reviews].each do |video_id,value|
      item = QueueItem.find(video_id)
      item.update_rating(value) if item.user_id == current_user.id 
    end
  end

  end

  def update_queue_item_list_order
    ActiveRecord::Base.transaction do 
      params[:queue_items].each do |video_id,value|
        item = QueueItem.find(video_id)
        item.update!(list_order:value) if item.user_id == current_user.id
      end
    end
  end

end


