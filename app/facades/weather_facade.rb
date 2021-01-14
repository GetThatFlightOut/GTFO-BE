class WeatherFacade
  def self.get_updated_weather(lat, long)
    latest_weather = *(0..7).map do |days|
      seconds = days * 24 * 60 * 60
      Weather.where(date: (Time.zone.now.beginning_of_day + seconds)..(Time.zone.now.end_of_day + seconds))
             .where('created_at >= ?', Time.zone.now - (6 * 60 * 60))
             .where(lat: lat)
             .where(long: long)
             .limit(1)
    end

    latest_weather.flatten!

    if latest_weather.length >= 8

      latest_weather
    else
      weather_data = WeatherService.get_weather(lat, long)[:data]

      weather_data.map do |weather_day|
        weather_day[:attributes][:lat] = lat
        weather_day[:attributes][:long] = long
        Weather.create(weather_day[:attributes])
      end

    end
  end
end
