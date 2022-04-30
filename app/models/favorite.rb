class Favorite < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant, :user

  def self.is_favorite(user, restaurant)
    Favorite.exists?(user: user, restaurant: restaurant)
  end
end
