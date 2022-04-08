class RemoveUserFromVotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :user, :string
  end
end
