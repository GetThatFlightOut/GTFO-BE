class Trip < ApplicationRecord
  has_many :trip_weathers
  has_many :weathers, through: :trip_weathers

  has_many :request_trips
  has_many :requests, through: :request_trips

  # attr_reader :id,
  #             :origin_city,
  #             :destination_city,
  #             :origin_iata,
  #             :destination_iata,
  #             :latitude,
  #             :longitude,
  #             :price,
  #             :departure_datetime,
  #             :arrival_datetime,
  #             :r_departure_datetime,
  #             :r_arrival_datetime,
  #             :booking_link,
  #             :trip_duration,
  #             :flight_id,
  #             :min_f,
  #             :max_f,
  #             :min_c,
  #             :max_c,
  #             :day_feels_like_c,
  #             :day_feels_like_f,
  #             :description,
  #             :weather_date,
  #             :weather,
  #             :sky_coverage

  def self.new_trip(flight, weather, index)
    data = {
    id: index,
    origin_city: flight[:attributes][:origin_city],
    destination_city: flight[:attributes][:destination_city],
    origin_iata: flight[:attributes][:origin_iata],
    destination_iata: flight[:attributes][:destination_iata],
    latitude: flight[:attributes][:latitude],
    longitude: flight[:attributes][:longitude],
    price: flight[:attributes][:price],
    departure_datetime: flight[:attributes][:departure_datetime],
    arrival_datetime: flight[:attributes][:arrival_datetime],
    r_departure_datetime: flight[:attributes][:r_departure_datetime],
    r_arrival_datetime: flight[:attributes][:r_arrival_datetime],
    booking_link: flight[:attributes][:booking_link],
    trip_duration: flight[:attributes][:trip_duration],
    flight_id: flight[:attributes][:id]
  }
    # min_f: weather[:data][0][:attributes][:min_f], # remove
    # max_f: weather[:data][0][:attributes][:max_f], # remove
    # min_c: weather[:data][0][:attributes][:min_c], # remove
    # max_c: weather[:data][0][:attributes][:max_c], # remove
    # day_feels_like_c: weather[:data][0][:attributes][:day_feels_like_c], # remove
    # day_feels_like_f: weather[:data][0][:attributes][:day_feels_like_f], # remove
    # description: weather[:data][0][:attributes][:description], # remove
    # weather_date: weather[:data][0][:attributes][:date], # remove
    # sky_coverage: weather[:data][0][:attributes][:sky_coverage], # remove
    weather_data = weather[:data]


    trip_object = create(data)

    weather_data.each do |weather_day|
      trip_object.weathers << Weather.create(weather_day[:attributes])
    end

    trip_object
  end
end
