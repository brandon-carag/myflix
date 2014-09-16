class QueueItemsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @queue_items=current_user.queue_items
    video_ids = @queue_items.map { |item|item.video_id } #Produces an array of video ids
    @videos=video_ids.map { |id| Video.find(id) }
  end

end