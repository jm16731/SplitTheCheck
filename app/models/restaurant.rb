class Restaurant < ApplicationRecord
  has_many :vote, dependent: :destroy
  has_many :user, through: :vote

  validates :name, :location, presence: true

  #scope logic by https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  scope :search_by_name,
    -> (name) { where("name like ?", "#{name}%") }
  scope :search_by_location,
    -> (location) { where("location like ?", "#{location}%") }


  #Leftover will_split and wont_split from previous version

  #validates :will_split, :wont_split, presence: true
  #validates :will_split, :wont_split, numericality: {
  #  greater_than_or_equal_to: 0
  #}

  def thumbs_up(user)
    #update_attribute(:will_split, will_split + 1)
    self.vote.create!(
      split: true,
      user: user
    )
  end

  def thumbs_down(user)
    #update_attribute(:wont_split, wont_split + 1)
    self.vote.create!(
      split: false,
      user: user
    )
  end

  def total_thumbs_up()
    self.vote.where(votes: { split: true }).count
  end

  def total_thumbs_down()
    self.vote.where(votes: { split: false }).count
  end

end
