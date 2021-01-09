class SearchController < ApplicationController
  def index
    #params from user are:
      #departure date
      #duration(num of days)
      #departure airport code e.g. DEN
    
    #user inputs need to be translated to:

    #user_params = {
      # :fly_from => 'DEN',
      # :date_from => '02/02/2021', (departure date)
      # :date_to => '02/02/2021', (departure date)
      # :nights_in_dst_from => 5, (duration)
      # :nights_in_dst_to => 5, (duration)
      # :limit => 20
      # }
    #faraday call to flights
    #flights = TripFacade.get_trips(user_params)
    # in TripFacade we call both the flight and weather service
    ## first the flights, then for each flight call the weather service
    #weather poro built in a method in the TripFacade.get_weather
    #inside get_weather we call the WeatherService 
    
    #weather poro
    #flights is an array of 'trip' objects?
    #

    #
  end
end