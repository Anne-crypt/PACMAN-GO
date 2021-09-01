class Participation < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validate :max_players, on: :create

  private

  def max_players
    if game.participations.size >= 4
      errors.add :base, "Party is already full"
    end
  end

end
