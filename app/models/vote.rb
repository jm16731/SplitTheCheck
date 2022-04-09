class Vote < ApplicationRecord
    belongs_to :restaurant
    belongs_to :user

    validates :split, presence: true

    def total_thumbs_up(restaurant_id)
      0
      #Votes.count.
      #group(:restaurant).having(restaurant: {id: restaurant_id}).
      #where(split: true)
    end

    def total_thumbs_down(restaurant_id)
      0
      #Votes.count.
      #group(:restaurant).having(restaurant: {id: restaurant_id}).
      #where(split: false)
    end
end

  #SELECT COUNT(*)
  #FROM Votes
  #GROUP BY restaurant.id
  #HAVING restaurant.id = ?
  #WHERE split = true
