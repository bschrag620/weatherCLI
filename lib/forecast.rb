module Forecast
    class Day
        attr_accessor :day, :date, :max, :min, :temperature_units, :wind_direction, :wind_magnitude, :wind_units, :short_detail, :long_detail, :humidity, :precipitation

        include Modules::MassInitialize::InstanceMethods
    end

end
