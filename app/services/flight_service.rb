class FlightService
  def self.get_flights(flight_params)
    response = conn.get '/flights' do |req|
      req.params['fly_from'] = flight_params[:departure_airport]
      req.params['date_from'] = flight_params[:departure_date]
      req.params['date_to'] = flight_params[:departure_date]
      req.params['nights_in_dst_from'] = flight_params[:trip_duration]
      req.params['nights_in_dst_to'] = flight_params[:trip_duration]
      req.params['limit'] = flight_params[:limit]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new(ENV['FLIGHT_API_HOST'])
  end
end
