class Restaurant < ApplicationRecord
  validates :name, :location, :will_split, :wont_split, presence: true
  validates :will_split, :wont_split, numericality: {
    greater_than_or_equal_to: -1
  }

  scope :search_by_name,
    -> (name) { where("name like ?", "#{name}%") }
  scope :search_by_location,
    -> (location) { where("location like ?", "#{location}%") }
end
