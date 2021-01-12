class WeatherService
  def self.get_weather(latitude, longitude)
    response = conn.get('/api/v1/weather') do |req|
      req.params['lat'] = latitude
      req.params['lon'] = longitude
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new(ENV['WEATHER_API_HOST'])
  end
end
