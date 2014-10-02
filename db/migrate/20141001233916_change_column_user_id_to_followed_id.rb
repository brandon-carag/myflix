class ChangeColumnUserIdToFollowedId < ActiveRecord::Migration
  def change
    rename_column :followings,:user_id,:followed_id
  end
end
