class Api::V1::SearchController < ApplicationController
  def index
    trips = TripFacade.get_trips(flight_params)
    if trips.class == Hash
      payload = {
          error: "Invalid Data",
          status: 400
        }
      render :json => payload, :status => :bad_request
    else
      render json: TripSerializer.new(trips)
    end
  end

  def flight_params
    params.permit(:departure_airport, :departure_date, :trip_duration, :limit)
  end
end
