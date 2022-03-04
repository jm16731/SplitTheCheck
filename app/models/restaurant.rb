class Restaurant < ApplicationRecord
  validates :name, :location, :will_split, :wont_split, presence: true
  validates :will_split, :wont_split, numericality: {
    greater_than_or_equal_to: -1
  }

  #scope logic by https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  scope :search_by_name,
    -> (name) { where("name like ?", "#{name}%") }
  scope :search_by_location,
    -> (location) { where("location like ?", "#{location}%") }
end
