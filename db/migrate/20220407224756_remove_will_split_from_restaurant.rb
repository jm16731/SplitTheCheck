class RemoveWillSplitFromRestaurant < ActiveRecord::Migration[6.1]
  def up
  	remove_column :restaurants, :will_split
  end

  def down
  	add_column :restaurants, :will_split, :integer
  end
end
