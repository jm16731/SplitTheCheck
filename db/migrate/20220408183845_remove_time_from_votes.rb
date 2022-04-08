class RemoveTimeFromVotes < ActiveRecord::Migration[6.1]
  def up
  	remove_column :votes, :time
  end

  def down
  	add_column :votes, :time, :timestamp
  end
end
