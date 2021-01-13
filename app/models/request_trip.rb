class RequestTrip < ApplicationRecord
  belongs_to :trip
  belongs_to :request

end
