class Player < ApplicationRecord

  has_many :games, dependent: :destroy
  has_many :participations, dependent: :destroy

end
