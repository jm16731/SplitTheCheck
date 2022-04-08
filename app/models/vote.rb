class Vote < ApplicationRecord
    belongs_to :restaurants
    belongs_to :users

    validates :split, presence: true

    def total_thumbs_up(restaurant_id)
      0
      =begin
        Votes.count.
        group(:restaurant).having(restaurant: {id: restaurant_id}).
        where(split: true)

      SELECT COUNT(*)
      FROM Votes
      GROUP BY restaurant.id
      HAVING restaurant.id = ?
      WHERE split = true
      =end
    end

    def total_thumbs_down(restaurant_id)
      0
      =begin
      Votes.count.
      group(:restaurant).having(restaurant: {id: restaurant_id}).
      where(split: false)
      =end
    end
end
