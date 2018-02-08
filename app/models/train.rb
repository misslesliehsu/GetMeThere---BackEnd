class Train < ApplicationRecord
  has_many :fave_trains
  has_many :users, through: :fave_trains
end
