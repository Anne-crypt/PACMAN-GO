class Game < ApplicationRecord
  belongs_to :player
  has_many :items, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :players, through: :participations

  validates :particpations, length: { is: 4 }

  COLORS=["red", "blue", "orange", "pink", "green"]

end
