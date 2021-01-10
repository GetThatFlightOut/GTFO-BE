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
end
