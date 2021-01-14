require 'rails_helper'

describe TripWeather, type: :model do
  describe 'relationships' do
    it do
      should belong_to :weather
      should belong_to :trip
    end
  end
end
