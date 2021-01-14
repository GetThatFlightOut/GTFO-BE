class Api::V1::TripsController < ApplicationController
  def show
    trip = Trip.find(params[:id])

    output = TripSerializer.new(trip)

    render json: output
  end
end
