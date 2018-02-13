class FaveTrain < ApplicationRecord
  belongs_to :user
  belongs_to :train
  belongs_to :station
end
