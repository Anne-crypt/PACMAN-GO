class Player < ApplicationRecord
  has_many :games #que pour les hosts
  has_many :participations
end
