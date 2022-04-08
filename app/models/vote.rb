class Vote < ApplicationRecord
    belongs_to :restaurants
    belongs_to :users
end
