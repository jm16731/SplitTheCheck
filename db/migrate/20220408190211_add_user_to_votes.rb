class AddUserToVotes < ActiveRecord::Migration[6.1]
  def change
      add_reference :votes, :user, foreign_key: true
  end
end
