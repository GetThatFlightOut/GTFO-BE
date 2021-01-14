# README
# GTFO-BE
![image](https://user-images.githubusercontent.com/68172332/104384272-6d70f100-54ee-11eb-94ba-287258e83de7.png)

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install GTFO-BE](#how-to-install-gtfo-be)
  - [API Contract](#api-contract)
  - [Schema](#schema)
  - [Dependencies](#dependencies)
  - [Testing](#testing)
  - [Learning Goals](#learning-goals)
  - [Licenses](#licenses)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)

## What it does

This project part of a Service-Oriented Architecture (SOA) application that provides users with flight and weather information based on search parameters that the user provides. The GTFO-BE serves as an intermediary from the GTFO-FE repo and the Weather-API and Flight-API repos. This service collects data from both the Weather and Flight APIs and compiles the data into one service that the front end can call. 

To view the production site, please visit the [GTFO link](https://gtfo-fe.herokuapp.com/).

To view the other components of the application please visit the [Github Project Organization](https://github.com/GetThatFlightOut).

## How to Install GTFO-BE

For usage on your local machine follow the instructions listed below:

```
git clone git@github.com:GetThatFlightOut/GTFO-BE.git
cd GTFO-BE
bundle install
rake db:{create,migrate}
rails server
visit localhost:3000 in your web browser
```

To see an example response like that below you can use [Postman](https://www.postman.com/) to send a GET request to our BE hosted on Heroku here: https://gtfo-be.herokuapp.com/api/v1/search

Required parameters:

`:departure_airport` - (string) - the IATA code of the origin airport

`:departure_date` - (string) - %d/%m/%y - the earliest date considered for departing flight

`:trip_duration` - (integer) - the number of days planned for the round trip

`:limit` - (integer) - the maximum number of results to be returned (default is currently 20 fo the index page)

Sample view of an API call in Postman:
![trips_call](https://user-images.githubusercontent.com/7945439/104528708-391c3400-55c5-11eb-807d-b95c37e0a4ae.png)


## API Contract

* Link to see the examples in real-time
Example of BackEnd to FrontEnd JSON
```
{
  "data":
    [
      {
        "id":0 (sequential number of trips, zero-indexed),
        "type":"trip",
        "attributes":
          {
            "origin_city":"Denver",
            "destination_city":"Houston",
            "origin_iata":"DEN",
            "destination_iata":"IAH",
            "latitude":29.9844444,
            "longitude":-95.341389,
            "price":49,
            "departure_datetime":"2021-01-30T10:07:00.000+00:00",
            "arrival_datetime":"2021-01-30T13:32:00.000+00:00",
            "r_departure_datetime":"2021-02-04T14:41:00.000+00:00",
            "r_arrival_datetime":"2021-02-04T16:19:00.000+00:00",
            "booking_link":
            "https://www.kiwi.com/deep?from=DEN&to=IAH&flightsId=0713230e48e1000055702f9c_0%7C230e071348e6000063003075_0&price=40&passengers=1&affilid=picky&lang=en&currency=USD&booking_token=BH6d3ZbUWgOg05ck0nutzMR4nWvyYNTeEM_aYAd77NEcM60o7L5uTwn1n3qwVJJSXxQHxqIz78x2u1OxJ0GUu4sfBcHo8HjNSsF9H4Vai0ikkuKhcANGpQhfH-JUuXVibvGRT3DpV1MlmLQ7KSomq_gzNK3squKcjEoMh4xoG8zcpYlPFgVXRHEpBB1U-elSTs0tq9IPMmqPLTPuYP-PZfQxUcwyO3SSWEr1P5N1P24UpGqcyTLSc_RfzwnIj0xe4JAYifMo9eqtftdHuMQleLmgL6JNAYNcRJGeEitGpj8ScrCV-dHmybWwNdJcZOL_HtS8sY8aKH9SC9Rm0spEZ63VLPX_dGZ40s6BPR-Xc294MijvJi5f9l8IspbxGQqx6hpcYXcXrJeP1Hkva3Ckj6cXdNsUE0lbG-cDFbsMT_us9GBRpeuBx3MFYmZiGaD8BDj7QvuInX9KLexxdjgul-DTbx3AruY0U1cx3_X-CiQuBDUHAJXcJyY7d9PuRnoKCH15-YuwJaMGx7ykEKHy84iieVT_S9Uv-4R8ElVEUAXfnrFch1CANNx3D02B0oQRp-N3g-09jEQGmLvKd-d1Zcia3M3mpVz1VDdyfyy7_X8AkSx5x02LK0MiESKqV2_EFWGobFuw0GrYScsvJ_XuLgrmeWVhQszHfDKuYNPXo71U=",
            "trip_duration":5,
            "flight_id":242,
            "min_f":30.400000000000034,
            "max_f":34.99000000000001,
            "min_c":-1.599999999999966,
            "max_c":2.990000000000009,
            "day_feels_like_c":-7.0499999999999545,
            "day_feels_like_f":24.950000000000045,
            "description":"clear sky",
            "weather_date":"2021-01-09T02:00:00+00:00",
            "sky_coverage":20,
            "weather": [
                          {
                            :type=>"weather",
                            :id=>nil,Â
                            :attributes=>
                            {
                             :min_f=>30.400000000000034,
                             :max_f=>34.99000000000001,
                             :min_c=>-1.599999999999966,
                             :max_c=>2.990000000000009,
                             :day_feels_like_c=>-7.0499999999999545,
                             :day_feels_like_f=>24.950000000000045,
                             :description=>"clear sky",
                             :date=>"2021-01-09T02:00:00+00:00"
                            }
                          },
                          {
                            :type=>"weather",
                            :id=>nil,Â
                            :attributes=>
                            {
                             :min_f=>30.400000000000034,
                             :max_f=>34.99000000000001,
                             :min_c=>-1.599999999999966,
                             :max_c=>2.990000000000009,
                             :day_feels_like_c=>-7.0499999999999545,
                             :day_feels_like_f=>24.950000000000045,
                             :description=>"clear sky",
                             :date=>"2021-01-10T02:00:00+00:00"
                            }
                          },
                          ...(there will be 8 days worth of weather forecast)
                        ]
                }
            }
      ]

}

```

This is an example of an error response for Invalid Data (Missing/Incorrect)
```
{
"error": "Invalid Data",
"status": 400
}
```

## Schema 

 <p align="center">
 <img src="https://i.imgur.com/OW5QQGw.png">
  </p>
  
 
## Dependencies


## Testing

* For testing our team implemented Travis CI with RSpec

> Travis CI is cloud based and when we submit a pull request, Travis will attempt to build our project and run the tests to ensure everything is working as expected. 

> RSpec is a tool for unit testing that will ensure we have the intended functionality at each level of our code. 

* In order to run the tests, run `bundle exec rspec` in the command line and you should have all passing tests.

## Learning Goals

  * Consume two external APIs
  
  * Build API's that return JSON responses
  
  * Refactor code for better code for improved organization/readability
  
  * Practice project management with project boards/daily standups/group retros
  
  * Utilize workflow: small commits, descriptive pull requests and code review
  
  * Write thorough and understandable documentation 
  
  * Utilize a Service-Oriented Architecture with a front-end, a back-end, and at least one micro-service 
  
## Licenses

  * Ruby 2.5.3
  * Rails 2.5.4.3
  * Travis CI Enterprise
  
## Contact

#### Todd Estes: [LinkedIn](https://www.linkedin.com/in/toddwestes/), [Email](mailto:elestes@gmail.com), [GitHub](https://github.com/Todd-Estes)
 
#### Connor Ferguson: [LinkedIn](https://www.linkedin.com/in/connor-p-ferguson/), [Email](mailto:cpfergus1@gmail.com), [GitHub](https://github.com/cpfergus1)
 
#### George Soderholm: [LinkedIn](https://www.linkedin.com/in/george-soderholm-05776947/), [Email](mailto:georgesoderholm@gmail.com), [GitHub](https://github.com/GeorgieGirl24)
    
#### Sage Freeman-Gonzales: [LinkedIn](https://www.linkedin.com/in/sagefreemangonzales/), [Email](mailto:sagegonzales15@gmail.com), [GitHub](https://github.com/SageOfCode)
 
#### Sheryl Stillman: [LinkedIn](https://www.linkedin.com/in/sherylstillman1/), [Email](mailto:sheryl.stillman@gmail.com), [GitHub](https://github.com/stillsheryl)
    
#### Aidan Murray:  [LinkedIn](http://www.linkedin.com/in/aidan-murray-teknoserval), [Email](mailto:aidanhansm@gmail.com), [GitHub](https://github.com/TeknoServal)
      
#### Jesse Mellinger: [LinkedIn](https://www.linkedin.com/in/jesse-mellinger/), [Email](mailto:jesse.m.mellinger@gmail.com), [GitHub](https://github.com/JesseMellinger)
        
#### Nick King: [LinkedIn](https://www.linkedin.com/in/nick-king-3128501ba/), [Email](mailto:nickmaxking@gmail.com), [GitHub](https://github.com/nmking22)
 
#### Brian Liu: [LinkedIn](https://www.linkedin.com/in/brian-liu-8356287b/), [Email](mailto:brian.b.liu@gmail.com), [GitHub](https://github.com/badgerbreezy)
    
#### Will Dunlap: [LinkedIn](https://www.linkedin.com/in/willwdunlap/), [Email](mailto:dunlapww@gmail.com), [GitHub](https://github.com/dunlapww)
   
## Acknowledgments
