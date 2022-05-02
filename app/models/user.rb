class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  has_many :vote, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :comment, dependent: :destroy

  has_many :restaurant, through: :vote
  has_many :restaurant, through: :favorite
  has_many :restaurant, through: :comment

  scope :search_by_user,
    -> (email) { where("email like ?", "#{email}%") }

  def favorite_restaurants
    Restaurant.joins(:favorite).where(favorites: { user: self })
  end

  def voted_restaurants
    Restaurant.joins(:vote).group(:id).where(votes: { user: self } )
  end
end
