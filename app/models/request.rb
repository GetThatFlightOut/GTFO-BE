class Request < ApplicationRecord
  has_many :request_trips
  has_many :trips, through: :request_trips

end
