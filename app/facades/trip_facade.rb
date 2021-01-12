class TripFacade
  def self.get_trips(flight_params)
    flights = FlightService.get_flights(flight_params)
    @trips = []

    if flights[:message].nil?
      mutex = Mutex.new
      threads = []
      flights[:data].each_with_index do |flight, index|
        threads << Thread.new do
          Rails.application.executor.wrap do
            t = Thread.current
            # Thread.start(t)

            lat = flight[:attributes][:latitude]
            lon = flight[:attributes][:longitude]
            weather = WeatherService.get_weather(lat, lon)
            t[:trip] = Trip.new(flight, weather, index)
          end
        end
      end
      # require 'pry'; binding.pry
      threads.map(&:value).flatten
      # require 'pry'; binding.pry
      threads.each do |t|
        # require 'pry'; binding.pry
        @trips << t[:trip]
        t.exit
      end
      # require 'pry'; binding.pry
      # render text: "Finished #{flights.length} blocking operations asynchronously."
      @trips # return value: an array of Trip Objects

    else
      flights
    end
  end
end
