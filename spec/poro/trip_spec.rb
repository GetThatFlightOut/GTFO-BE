require 'rails_helper'

RSpec.describe Trip do
  it 'exists and has attributes' do
    flight =
      {
        :id=>"0",
        :type=>"trip",
        :attributes=>
          {
            :origin_city=>"Denver",
            :destination_city=>"Houston",
            :origin_iata=>"DEN",
            :destination_iata=>"IAH",
            :latitude=>29.9844444,
            :longitude=>-95.341389,
            :price=>49,
            :departure_datetime=>"2021-01-30T10:07:00.000+00:00",
            :arrival_datetime=>"2021-01-30T13:32:00.000+00:00",
            :r_departure_datetime=>"2021-02-04T14:41:00.000+00:00",
            :r_arrival_datetime=>"2021-02-04T16:19:00.000+00:00",
            :booking_link=>
            "https://www.kiwi.com/deep?from=DEN&to=IAH&flightsId=0713230e48e1000055702f9c_0%7C230e071348e6000063003075_0&price=40&passengers=1&affilid=picky&lang=en&currency=USD&booking_token=BH6d3ZbUWgOg05ck0nutzMR4nWvyYNTeEM_aYAd77NEcM60o7L5uTwn1n3qwVJJSXxQHxqIz78x2u1OxJ0GUu4sfBcHo8HjNSsF9H4Vai0ikkuKhcANGpQhfH-JUuXVibvGRT3DpV1MlmLQ7KSomq_gzNK3squKcjEoMh4xoG8zcpYlPFgVXRHEpBB1U-elSTs0tq9IPMmqPLTPuYP-PZfQxUcwyO3SSWEr1P5N1P24UpGqcyTLSc_RfzwnIj0xe4JAYifMo9eqtftdHuMQleLmgL6JNAYNcRJGeEitGpj8ScrCV-dHmybWwNdJcZOL_HtS8sY8aKH9SC9Rm0spEZ63VLPX_dGZ40s6BPR-Xc294MijvJi5f9l8IspbxGQqx6hpcYXcXrJeP1Hkva3Ckj6cXdNsUE0lbG-cDFbsMT_us9GBRpeuBx3MFYmZiGaD8BDj7QvuInX9KLexxdjgul-DTbx3AruY0U1cx3_X-CiQuBDUHAJXcJyY7d9PuRnoKCH15-YuwJaMGx7ykEKHy84iieVT_S9Uv-4R8ElVEUAXfnrFch1CANNx3D02B0oQRp-N3g-09jEQGmLvKd-d1Zcia3M3mpVz1VDdyfyy7_X8AkSx5x02LK0MiESKqV2_EFWGobFuw0GrYScsvJ_XuLgrmeWVhQszHfDKuYNPXo71U=",
            :trip_duration=>5,
            :id=>242
          }
      }

  weather = {
    :data=>
    [
      {
        :type=>"weather",
        :id=>nil,
        :attributes=>
        {
         :min_f=>30.400000000000034,
         :max_f=>34.99000000000001,
         :min_c=>-1.599999999999966,
         :max_c=>2.990000000000009,
         :day_feels_like_c=>-7.0499999999999545,
         :day_feels_like_f=>24.950000000000045,
         :description=>"clear sky",
         :date=>"2021-01-09T02:00:00+00:00",
         :sky_coverage=>20
        }
      },
      {
        :type=>"weather",
        :id=>nil,
        :attributes=>
        {
         :min_f=>30.400000000000034,
         :max_f=>45.99000000000001,
         :min_c=>-4.599999999999966,
         :max_c=>6.990000000000009,
         :day_feels_like_c=>-5.0499999999999545,
         :day_feels_like_f=>47.950000000000045,
         :description=>"mist",
         :date=>"2021-01-10T02:00:00+00:00",
         :sky_coverage=>40
        }
      }
    ]
  }
  trip = Trip.new(flight, weather, 0)

  expect(trip).to be_a Trip
  expect(trip.id).to eq(0)
  expect(trip.origin_city).to eq(flight[:attributes][:origin_city])
  expect(trip.flight_id).to eq(flight[:attributes][:id])
  expect(trip.min_f).to eq(weather[:data][0][:attributes][:min_f])
  expect(trip.description).to eq(weather[:data][0][:attributes][:description])
  expect(trip.weather_date).to eq(weather[:data][0][:attributes][:date])
  expect(trip.weather.count).to eq(2)
  expect(trip.weather[1][:attributes][:date]).to eq(weather[:data][1][:attributes][:date])
  expect(trip.weather[0][:attributes][:date]).to_not eq(weather[:data][1][:attributes][:date])
  expect(trip.weather[0][:attributes][:min_c]).to_not eq(weather[:data][1][:attributes][:min_c])
  expect(trip.weather[0][:attributes][:sky_coverage]).to_not eq(weather[:data][1][:attributes][:sky_coverage])
  end
end
