class Api::V1::RequestsController < ApplicationController
  def show
    request = Request.find(params[:id])

    options = {}
    options[:include] = %i[trips]

    output = RequestSerializer.new(request, options).serialized_json

    render json: output
  end
end
