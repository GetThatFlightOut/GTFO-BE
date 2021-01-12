require 'rails_helper'

RSpec.describe TripFacade do
  describe 'class methods', :vcr do
    it '.get_trips' do
      flight_params = {
              :departure_airport => 'DEN',
              :departure_date => '30/01/2021',
              :trip_duration => 5,
              :limit => 20
              }

      trips = TripFacade.get_trips(flight_params)
      expect(trips).to be_an Array
      expect(trips.count).to eq(20)
      expect(trips.first).to be_a Trip
    end
  end

  describe 'instance methods' do

  end
end
