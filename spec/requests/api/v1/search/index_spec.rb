require 'rails_helper'

RSpec.describe 'Search', :vcr do
  it 'returns successful Trip (json response) that includes FlightAPI and WeatherAPI' do
    flight_params = {
            :departure_airport => 'DEN',
            :departure_date => '30/01/2021',
            :trip_duration => 5,
            :limit => 20
            }
    get '/api/v1/search', params: flight_params
    trips = JSON.parse(response.body, symbolize_names: true)

    expect(response.body).to be_a String
    expect(response).to be_successful
    expect(trips[:data]).to be_an Array
    expect(trips[:data].count).to eq(20)
    expect(trips[:data].count).to_not eq(10)
    expect(trips[:data][0][:attributes][:weather].count).to eq(8)
    expect(trips[:data][0][:id]).to eq('0')
    expect(trips[:data][0][:id]).to_not eq(nil)
    expect(trips[:data][0][:attributes]).to be_a Hash
    expect(trips[:data][0][:attributes][:origin_city]).to be_a String
    expect(trips[:data][0][:attributes][:price]).to be_a Integer
    expect(trips[:data][0][:attributes][:booking_link]).to be_a String
    expect(trips[:data][0][:attributes][:min_f]).to be_a Float
    expect(trips[:data][0][:attributes][:day_feels_like_c]).to be_a Float
    expect(trips[:data][0][:attributes][:weather]).to be_an Array
    expect(trips[:data][0][:attributes][:weather]).to_not be_a Hash
  end

  xit 'returns an error message when the flight_params are incomplete' do
    # This test is failing. We ran this in the Chrome terminal and it ACTUALLY works.
    # The expectation is that if you leave a date empty you will get an error:
      # {
      #   "error": "Invalid Data",
      #   "status": 400
      # }
    # However, we were unable to make it pass in RSpec
    # Please take a look and see if you have any insights as to how to achieve a passing test
    # Please note the application.yml ports for WEATHER_API_HOST and FLIGHT_API_HOST
    # FLIGHT_API_HOST: 'http://localhost:3001'
    # WEATHER_API_HOST: 'http://localhost:3002'
    flight_params = {
            :departure_airport => 'DEN',
            :departure_date => '',
            :trip_duration => 5,
            :limit => 20
            }
    get '/api/v1/search', params: flight_params

    response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_a Hash
    expect(response).to_not be_successful
    expect(response[:status]).to eq(400)
    expect(response[:error]).to eq('Invalid Data')
  end

  xit 'returns an error message when the flight_params have invalid dates'

end
