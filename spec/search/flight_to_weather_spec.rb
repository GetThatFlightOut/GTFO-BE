require 'rails_helper'

describe 'As the BE' do
  describe 'When I get flight data back from the flight microservice' do
    before :each do
      @user_params = {
        fly_from: 'DEN',
        date_from: '02/02/2021',
        date_to: '02/02/2021',
        nights_in_dst_from: 5,
        nights_in_dst_to: 5,
        limit: 20
      }
    end
    
    it 'I can make call to the weather API for each flight' do
      VCR.use_cassette('flight_data') do
        
        conn = Faraday.new('http://localhost:9393')

        response = conn.get '/flights' do |req|
          req.params['fly_from'] = @user_params[:fly_from]
          req.params['date_from'] = @user_params[:date_from]
          req.params['date_to'] = @user_params[:date_to]
          req.params['nights_in_dst_from'] = @user_params[:nights_in_dst_from]
          req.params['nights_in_dst_to'] = @user_params[:nights_in_dst_to]
          req.params['limit'] = @user_params[:limit]
        end

        flights = JSON.parse(response.body, symbolize_names: true)
        
        @trips = []

        flights[:data].each do |flight|
          conn2 = Faraday.new(url: 'http://localhost:9394')

          response2 = conn2.get('/api/v1/weather') do |req|
            req.params['lat'] = flight[:attributes][:latitude]
            req.params['lon'] = flight[:attributes][:longitude]
          end

          weather = JSON.parse(response2.body, symbolize_names: true)

          class Weather
            attr_reader :min_f,
                        :max_f,
                        :min_c,
                        :max_c,
                        :day_feels_like_c,
                        :day_feels_like_f,
                        :description,
                        :date

            def initialize(day_weather)
              @min_f = day_weather[:attributes][:min_f]
              @max_f = day_weather[:attributes][:max_f]
              @min_c = day_weather[:attributes][:min_c]
              @max_c = day_weather[:attributes][:max_c]
              @day_feels_like_c = day_weather[:attributes][:day_feels_like_c]
              @day_feels_like_f = day_weather[:attributes][:day_feels_like_f]
              @description = day_weather[:attributes][:description]
              @date = day_weather[:attributes][:date]
            end
          end
          
          
          class WeatherFacade
            def self.daily_weather(weather)
              weather[:data].map do |day|
                Weather.new(day)
              end
            end
          end
                    
          class Trip
            attr_reader :origin_city,
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
                        :id,
                        :min_f,
                        :max_f,
                        :min_c,
                        :max_c,
                        :day_feels_like_c,
                        :day_feels_like_f,
                        :description,
                        :weather_date,
                        :weather



            def initialize(flight, weather)
              @origin_city = flight[:attributes][:origin_city]
              @destination_city = flight[:attributes][:destination_city]
              @origin_iata = flight[:attributes][:origin_iata]
              @destination_iata = flight[:attributes][:destination_iata]
              @latitude = flight[:attributes][:latitude]
              @longitude = flight[:attributes][:longitude]
              @price = flight[:attributes][:price]
              @departure_datetime = flight[:attributes][:departure_datetime]
              @arrival_datetime = flight[:attributes][:arrival_datetime]
              @r_departure_datetime = flight[:attributes][:r_departure_datetime]
              @r_arrival_datetime = flight[:attributes][:r_arrival_datetime]
              @booking_link = flight[:attributes][:booking_link]
              @trip_duration = flight[:attributes][:trip_duration]
              @id = flight[:attributes][:id]
              @min_f = weather[:data][0][:attributes][:min_f]
              @max_f = weather[:data][0][:attributes][:max_f]
              @min_c = weather[:data][0][:attributes][:min_c]
              @max_c = weather[:data][0][:attributes][:max_c]
              @day_feels_like_c = weather[:data][0][:attributes][:day_feels_like_c]
              @day_feels_like_f = weather[:data][0][:attributes][:day_feels_like_f]
              @description = weather[:data][0][:attributes][:description]
              @weather_date = weather[:data][0][:attributes][:date]
              @weather = WeatherFacade.daily_weather(weather)
            end
          end

          @trips << Trip.new(flight, weather)
        end
        #Sage/George/Jesse, look at @trips variable contents.  This is what needs to
        #be serialized.  Also note that are no attributes called 'sky-coverage', 'chance_precip', or 'weather_data_available'
        require 'pry'; binding.pry
      end
    end
  end
end
