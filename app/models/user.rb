class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  has_many :vote, dependent: :destroy
  has_many :restaurant, through: :vote

  scope :search_by_user,
    -> (email) { where("email like ?", "#{email}%") }
end
