class AddAuthTokensToUserModel < ActiveRecord::Migration
  def change
    add_column(:users, :auth_token, :string)
    add_column(:users, :auth_token_created_at, :datetime)
  end
end
