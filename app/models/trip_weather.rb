class TripWeather < ApplicationRecord
  belongs_to :weather
  belongs_to :trip

end
