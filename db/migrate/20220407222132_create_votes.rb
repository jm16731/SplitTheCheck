class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.string :restaurant
      t.string :user
      t.boolean :split
      t.timestamp :time

      t.timestamps
    end
  end
end
