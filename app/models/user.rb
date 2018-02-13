class User < ApplicationRecord
  has_many :fave_trains
  has_many :trains, through: :fave_trains
  has_secure_password
end
