class Api::V1::SearchController < ApplicationController
  def index
    trips = TripFacade.get_trips(flight_params)

    render json: TripSerializer.new(trips)
    # binding.pry
  end

  def flight_params
    params.permit(:departure_airport, :departure_date, :trip_duration, :limit)
  end
end
