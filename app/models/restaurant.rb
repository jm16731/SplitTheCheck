class Restaurant < ApplicationRecord
  validates :name, :location, :will_split, :wont_split, presence: true
  validates :will_split, :wont_split, numericality: {
    greater_than_or_equal_to: -1
  }
end
