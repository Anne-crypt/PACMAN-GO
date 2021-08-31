class Game < ApplicationRecord
  belongs_to :player
  has_many :items, dependent: :destroy
  has_many :participations, dependent: :destroy

  COLORS=["red", "blue", "orange", "pink", "green"]

end
