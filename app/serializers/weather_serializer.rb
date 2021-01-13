class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :max_f,
             :min_f,
             :min_c,
             :max_c,
             :day_feels_like_f,
             :day_feels_like_c,
             :description,
             :date,
             :sky_coverage
end
