class QueueItemsController < ApplicationController
  before_action :require_login, only: [:index,:create,:destroy]

  def sort_list_order
    counter = 1
    array = params[:queue_items].sort_by{ |k,v| v }
    array.each do |k,v|
      item = QueueItem.find(k.to_i) 
      item.update(list_order:counter)
      counter +=1
    end

    redirect_to queue_items_path

    #Order the queue items array based upon the list_order
    #Use a transaction to update the queue_item_objects with the correct list order
    #Initialize a counter.  Renumber each one.

    #hash format: params[queue_items] = { queue_item_id => list_order, queue_item_id => list_order }
    


  end

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