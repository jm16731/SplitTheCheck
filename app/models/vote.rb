class Vote < ApplicationRecord
    belongs_to :restaurants
    belongs_to :users

    validates :split, :time, presence: true
end
