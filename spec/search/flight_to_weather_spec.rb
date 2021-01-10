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

        flights[:data].each_with_index do |flight, index|
          conn2 = Faraday.new(url: 'http://localhost:9394')

          response2 = conn2.get('/api/v1/weather') do |req|
            req.params['lat'] = flight[:attributes][:latitude]
            req.params['lon'] = flight[:attributes][:longitude]
        end
        weather = JSON.parse(response2.body, symbolize_names: true)

          @trips << Trip.new(flight, weather, index)
          trip_serializer = TripSerializer.new(@trips)
          binding.pry
        end
        #Sage/George/Jesse, look at @trips variable contents.  This is what needs to
        #be serialized.  Also note that are no attributes called 'sky-coverage', 'chance_precip', or 'weather_data_available'
        # require 'pry'; binding.pry
      end

      it 'can return a serialized trip response' do

      end
    end
  end
end
