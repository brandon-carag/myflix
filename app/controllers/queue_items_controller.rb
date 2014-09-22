class QueueItemsController < ApplicationController
  before_action :require_login, only: [:index,:create,:destroy,:sort_list_order]

  def sort_list_order
    counter = 1

    if params[:queue_items].values.map{|x|x.to_i}.include?(0)
      flash[:danger]="You can only re-order the queue by using integers and cannot use blanks."

    elsif params[:queue_items].values != params[:queue_items].values.uniq
      flash[:danger]="You must use unique integers when populating your queue selection."

    else
      array = params[:queue_items].sort_by{ |k,v| v.to_i }

      array.each do |k,v|
      item = QueueItem.find(k)
      item.update(list_order:counter)
      counter +=1
      end
    end

    redirect_to queue_items_path

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


#This is the array it's having issues sorting: [["20", "100"], ["21", "2"], ["22", "3"]]