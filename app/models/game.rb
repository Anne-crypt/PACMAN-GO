class Game < ApplicationRecord
  belongs_to :player
  has_many :items, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :players, through: :participations

  validates :participations, length: { is: 4 }

  COLORS=["red", "blue", "orange", "pink", "green"]

end
