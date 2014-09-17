class QueueItemsController < ApplicationController
  before_action :require_login, only: [:index,:create,:destroy]

  def index
    @queue_items=current_user.queue_items
    video_ids = @queue_items.map { |item|item.video_id } #Produces an array of video ids
    @videos=video_ids.map { |id| Video.find(id) }
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
    redirect_to queue_items_path
  end

end