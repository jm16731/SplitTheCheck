class Restaurant < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :name, :location, presence: true
  #validates :will_split, :wont_split, presence: true
  #validates :will_split, :wont_split, numericality: {
  #  greater_than_or_equal_to: 0
  #}

  #scope logic by https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  scope :search_by_name,
    -> (name) { where("name like ?", "#{name}%") }
  scope :search_by_location,
    -> (location) { where("location like ?", "#{location}%") }


  #def thumbs_up
  #  update_attribute(:will_split, will_split + 1)
  #end

  #def thumbs_down
  #  update_attribute(:wont_split, wont_split + 1)
  #end

end
