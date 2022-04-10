class Vote < ApplicationRecord
    belongs_to :restaurant
    belongs_to :user

    #thanks bricker for correct boolean logic here, https://stackoverflow.com/questions/7781174/rspec-validation-failed-attribute-cant-be-blank-but-it-isnt-blank
    validates :split, :inclusion => { :in => [true, false] }

end
