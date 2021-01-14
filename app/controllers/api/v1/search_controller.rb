class Api::V1::SearchController < ApplicationController
  def index
    request = Request.create(request_params)

    trips = TripFacade.get_trips(flight_params)

    if trips.instance_of?(Hash)
      payload = {
        error: trips[:message].first[:errors].first,
        status: 400
      }

      render json: payload, status: :bad_request
      return
    end

    trips.each { |trip| request.trips << trip }

    if request.limit.to_i == 1
      output = {
        data: [
          trip_id: request.trips[0].id
        ]
      }

      render json: output
    elsif request.limit.to_i >= 2
      output = {
        data: [
          request_id: request.id
        ]
      }

      render json: output
    end
  end

  def flight_params
    params.permit(:departure_airport, :departure_date, :trip_duration, :limit)
  end

  def request_params
    params.permit(:departure_airport, :departure_date, :trip_duration, :limit, :uid)
  end
end
