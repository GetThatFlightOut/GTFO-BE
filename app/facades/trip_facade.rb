class TripFacade
  def self.get_trips(flight_params)
    flights = FlightService.get_flights(flight_params)
    @trips = []

    if flights[:message].nil?
      threads = []
      # t = {}
      flights[:data].each_with_index do |flight, index|
        threads << Thread.new do
          Rails.application.executor.wrap do
            t = Thread.current
            # puts 'thread created'
            lat = flight[:attributes][:latitude]
            long = flight[:attributes][:longitude]

            # puts "#{lat}, #{long}, #{flight[:attributes][:destination_city]}"

            weather = WeatherFacade.get_updated_weather(lat, long)

            t[:trip] = Trip.new_trip(flight, weather, index)
          end
        end
      end
      # require 'pry'; binding.pry
      threads.map(&:value).flatten
      threads.each do |t|
        @trips << t[:trip]
        # t.join
        t.exit
      end

      @trips # return value: an array of Trip Objects

    else
      flights
    end
  end
end
