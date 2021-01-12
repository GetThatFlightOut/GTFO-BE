class TripFacade
  def self.get_trips(flight_params)
    flights = FlightService.get_flights(flight_params)
    trips = []

    if flights[:message].nil?
      # mutex = Mutex.new
      threads = []
      flights[:data].each_with_index do |flight, index|
        threads << Thread.new do
          t = Thread.current
          # mutex.synchronize do
          t[:lat] = flight[:attributes][:latitude]
          t[:lon] = flight[:attributes][:longitude]
          t[:weather] = WeatherService.get_weather(lat, lon)
          t[:trips] << Trip.new(flight, weather, index)
          sleep 0.5
          # end
        end
      end
      binding.pry
      threads.each do |t|
        t.join
        t.pass
      end
      # render text: "Finished #{flights.length} blocking operations asynchronously."
      trips #return value: an array of Trip Objects

    else
      flights
    end
  end
end
