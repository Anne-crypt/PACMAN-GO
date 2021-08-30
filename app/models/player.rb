class Player < ApplicationRecord

  has_many :games, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates_length_of :nickname, minimum: 2, maximum: 8, allow_blank: false, acceptance: { message: 'nickname must be between 2 and 8 characters max.' }

end
