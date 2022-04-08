class RemoveRestaurantFromVotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :restaurant, :string
  end
end
