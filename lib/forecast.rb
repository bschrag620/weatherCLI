module Forecast
    class Day
        attr_accessor :day, :date, :max, :min, :temperature_units, :wind_direction, :wind_magnitude, :wind_units, :short_detail, :long_detail, :humidity, :precipitation

        def initialize(hash_arg)
            hash_arg.each do |key, value|
                self.send("#{key}=", value)
            end
        end
    end

end
