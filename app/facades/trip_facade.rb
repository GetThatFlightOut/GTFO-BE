class TripFacade
  def self.get_trips(flight_params)
    flights = FlightService.get_flights(flight_params)
    trips = []
    flights[:data].each_with_index do |flight, index|
      lat = flight[:attributes][:latitude]
      lon = flight[:attributes][:longitude]
      weather = WeatherService.get_weather(lat, lon)
      trips << Trip.new(flight, weather, index)
      # binding.pry
    end
    trips #return value: an array of Trip Objects
  end
end
