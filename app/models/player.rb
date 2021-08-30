class Player < ApplicationRecord

  has_many :games, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates_length_of :nickname, minimum: 2, maximum: 12, format: { with: /\s/ }
  validates :nickname, format: { without: /\s/, message: "with whitespace not allowed" }

end
