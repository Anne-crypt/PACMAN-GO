class Item < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  belongs_to :game
end
