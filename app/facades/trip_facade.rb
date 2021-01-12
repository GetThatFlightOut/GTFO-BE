class TripFacade
  def self.get_trips(flight_params)
    flights = FlightService.get_flights(flight_params)
    @trips = []
    if flights[:message].nil?
      threads = []
      flights[:data].each_with_index do |flight, index|
        threads << Thread.new do
          Rails.application.executor.wrap do
            t = Thread.current

            lat = flight[:attributes][:latitude]
            lon = flight[:attributes][:longitude]
            weather = WeatherService.get_weather(lat, lon)
            t[:trip] = Trip.new(flight, weather, index)
          end
        end
      end
      threads.each do |t|
        @trips << t[:trip]
        t.exit
      end
      @trips #return value: an array of Trip Objects
    else
      flights
    end
  end
end
