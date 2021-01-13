class Weather < ApplicationRecord
  has_many :trip_weathers
  has_many :trips, through: :trip_weathers
end
