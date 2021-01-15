require 'rails_helper'

RSpec.describe 'Search', :vcr do
  it 'returns successful Trip (json response) that includes FlightAPI and WeatherAPI' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '30/01/2021',
      trip_duration: 5,
      limit: 20
    }
    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)

    get "/api/v1/requests/#{response_id[:data][:request_id]}"
    trips = JSON.parse(response.body, symbolize_names: true)

    expect(response.body).to be_a String
    expect(response).to be_successful

    expect(trips[:included]).to be_an Array
    expect(trips[:included].count).to eq(20)
    expect(trips[:included].count).to_not eq(10)
    expect(trips[:included][0][:attributes][:weather].count).to eq(8)
    expect(trips[:included][0][:id]).to_not eq(nil)
    expect(trips[:included][0][:attributes]).to be_a Hash
    expect(trips[:included][0][:attributes][:origin_city]).to be_a String
    expect(trips[:included][0][:attributes][:price]).to be_a Integer
    expect(trips[:included][0][:attributes][:booking_link]).to be_a String
    expect(trips[:included][0][:attributes][:min_f]).to be_a Float
    expect(trips[:included][0][:attributes][:day_feels_like_c]).to be_a Float
    expect(trips[:included][0][:attributes][:weather]).to be_an Array
    expect(trips[:included][0][:attributes][:weather]).to_not be_a Hash
  end

  it 'weather re-usage is performed correctly' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '30/01/2021',
      trip_duration: 5,
      limit: 20
    }
    puts '-------------- #1'
    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)

    # test again for weather re-usal

    puts '-------------- #2'
    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)

    puts '-------------- #3'
    get "/api/v1/requests/#{response_id[:data][:request_id]}"
    trips = JSON.parse(response.body, symbolize_names: true)

    expect(response.body).to be_a String
    expect(response).to be_successful

    expect(trips[:included]).to be_an Array
    expect(trips[:included].count).to eq(20)
    expect(trips[:included].count).to_not eq(10)
    expect(trips[:included][0][:attributes][:weather].count).to eq(8)
    expect(trips[:included][0][:id]).to_not eq(nil)
    expect(trips[:included][0][:attributes]).to be_a Hash
    expect(trips[:included][0][:attributes][:origin_city]).to be_a String
    expect(trips[:included][0][:attributes][:price]).to be_a Integer
    expect(trips[:included][0][:attributes][:booking_link]).to be_a String
    expect(trips[:included][0][:attributes][:min_f]).to be_a Float
    expect(trips[:included][0][:attributes][:day_feels_like_c]).to be_a Float
    expect(trips[:included][0][:attributes][:weather]).to be_an Array
    expect(trips[:included][0][:attributes][:weather]).to_not be_a Hash
  end

  it 'returns an error message when the flight_params are incomplete' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '',
      trip_duration: 5,
      limit: 20
    }

    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)

    expect(response_id).to be_a Hash
    expect(response_id[:status]).to eq(400)
    expect(response_id[:error]).to eq('Could not parse . Valid formats: %d/%m/%Y, %d/%m/%Y %H:%M')
  end

  it 'returns an error message when the flight_params have invalid dates' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '30/01/2030',
      trip_duration: 5,
      limit: 20
    }

    get '/api/v1/search', params: flight_params

    trips = JSON.parse(response.body, symbolize_names: true)

    expect(trips).to be_a Hash
    expect(trips[:status]).to eq(400)
    expect(trips[:error]).to eq('Year of the given date is far in the future.')
  end

  it 'returns one flight when lucky search request is received from front end' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '21/03/2021',
      trip_duration: 5,
      limit: 1
    }
    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)

    get "/api/v1/trips/#{response_id[:data][:trip_id]}"
    trip = JSON.parse(response.body, symbolize_names: true)

    expect(response.body).to be_a String
    expect(response).to be_successful
    expect(trip[:data]).to be_a Hash
    expect(trip[:data][:attributes][:weather].count).to eq(8)
    expect(trip[:data][:id]).to_not eq(nil)
    expect(trip[:data][:attributes]).to be_a Hash
    expect(trip[:data][:attributes][:origin_city]).to be_a String
    expect(trip[:data][:attributes][:price]).to be_a Integer
    expect(trip[:data][:attributes][:booking_link]).to be_a String
    expect(trip[:data][:attributes][:min_f]).to be_a Float
    expect(trip[:data][:attributes][:day_feels_like_c]).to be_a Float
    expect(trip[:data][:attributes][:weather]).to be_an Array
    expect(trip[:data][:attributes][:weather]).to_not be_a Hash
  end

  it 'returns error code when trip is not found' do
    get '/api/v1/trips/3285729847'
    trip = JSON.parse(response.body, symbolize_names: true)
    expect(trip[:error]).to be_a String
    expect(trip[:status]).to be(400)
  end

  it 'returns error code when request is not found' do
    get '/api/v1/requests/3285729847'
    request = JSON.parse(response.body, symbolize_names: true)
    expect(request[:error]).to be_a String
    expect(request[:status]).to be(400)
  end

  it 'returns error code when search is not found' do
    flight_params = {
      departure_airport: 'DEN',
      departure_date: '30/01/2021',
      trip_duration: 5000,
      limit: 20
    }
    get '/api/v1/search', params: flight_params
    response_id = JSON.parse(response.body, symbolize_names: true)
    expect(response_id[:error]).to be_a String
    expect(response_id[:status]).to be(400)
  end
end
