class RemoveWontSplitFromRestaurant < ActiveRecord::Migration[6.1]
  def up
  	remove_column :restaurants, :wont_split
  end

  def down
  	add_column :restaurants, :wont_split, :integer
  end
end
