class Game < ApplicationRecord
  belongs_to :player
  has_many :items, dependent: :destroy
  has_many :participations, dependent: :destroy
end
