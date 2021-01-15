require 'rails_helper'

describe WeatherFacade, type: :facade do
  describe 'class methods', :vcr do
    it 'requests and reuses weather objects' do
      weathers = WeatherFacade.get_updated_weather(50, 60)

      expect(weathers[0]).to be_a(Weather)

      weathers_new = WeatherFacade.get_updated_weather(50, 60)

      expect(weathers_new[0]).to be_a(Weather)
    end
  end
end
