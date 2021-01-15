class Api::V1::TripsController < ApplicationController
  def show
    begin
      trip = Trip.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      payload = {
        error: 'There was no request that matched your search.',
        status: 400
      }

      render json: payload, status: :bad_request
      return
    end
    output = TripSerializer.new(trip)

    render json: output
  end
end
