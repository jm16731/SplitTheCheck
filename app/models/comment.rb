class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  accepts_nested_attributes_for :restaurant, :user

  validates :comment, presence: true
end
