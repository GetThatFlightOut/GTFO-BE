class WeatherFacade
  def self.get_updated_weather(lat, long)
    latest_weather = *(0..7).map do |days|
      seconds = days * 24 * 60 * 60 # + (86400)
      Weather.where(date: (Time.current.beginning_of_day + seconds)..(Time.current.end_of_day + seconds))
             .where('created_at >= ?', Time.current - (6 * 60 * 60))
             .where(lat: lat)
             .where(long: long)
             .limit(1)
    end

    check_full_weather(latest_weather.flatten!, lat, long)
  end

  def self.check_full_weather(weather, lat, long)
    if weather.length >= 8
      puts "WEATHER REUSED"
      weather
    else
      weather_data = WeatherService.get_weather(lat, long)[:data]
      puts "WEATHER ACQUIRED"
      weather_data.map do |weather_day|
        weather_day[:attributes][:lat] = lat
        weather_day[:attributes][:long] = long
        Weather.create(weather_day[:attributes])
      end

    end
  end
end
