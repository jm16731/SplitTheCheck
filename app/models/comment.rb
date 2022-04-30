class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant, :user

  validates :comment, presence: true

  def self.comment_history(restaurant)
    Comment.where(restaurant: restaurant).
      order(timestamps: :desc)
  end
end
