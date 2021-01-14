class Api::V1::RequestsController < ApplicationController
  def show

    begin
    request = Request.find(params[:id])

    rescue ActiveRecord::RecordNotFound

      payload = {
        error: 'There was no request that matched your search.',
        status: 400
      }

      render json: payload, status: :bad_request
      return
    end


    options = {}
    options[:include] = %i[trips]

    output = RequestSerializer.new(request, options).serialized_json

    render json: output
  end
end
