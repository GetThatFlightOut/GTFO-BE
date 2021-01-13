class TripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin_city,
             :destination_city,
             :origin_iata,
             :destination_iata,
             :latitude,
             :longitude,
             :price,
             :departure_datetime,
             :arrival_datetime,
             :r_departure_datetime,
             :r_arrival_datetime,
             :booking_link,
             :trip_duration,
             :flight_id

  attributes :min_f do |trip|
    trip.weathers[0].min_f
  end

  attributes :max_f do |trip|
    trip.weathers[0].max_f
  end

  attributes :min_c do |trip|
    trip.weathers[0].min_c
  end

  attributes :max_c do |trip|
    trip.weathers[0].max_c
  end

  attributes :day_feels_like_f do |trip|
    trip.weathers[0].day_feels_like_f
  end

  attributes :day_feels_like_c do |trip|
    trip.weathers[0].day_feels_like_c
  end

  attributes :description do |trip|
    trip.weathers[0].description
  end

  attributes :weather_date do |trip|
    trip.weathers[0].date
  end

  attributes :sky_coverage do |trip|
    trip.weathers[0].sky_coverage
  end
  #  :max_f,
  #  :min_c,
  #  :max_c,
  #  :day_feels_like_f,
  #  :day_feels_like_c,
  #  :description,
  #  :weather_date,
  #  :sky_coverage,

  attributes :weather do |trip|
    trip.weathers.map do |weather|
      WeatherSerializer.new(weather)
    end
  end
end
