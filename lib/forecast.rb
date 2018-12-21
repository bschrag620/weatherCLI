module Forecast
    class Day
        attr_accessor   :day, :date, :max, :min, :temperature_units, :wind_direction, :wind_magnitude, :wind_units, :short_detail, 
                        :long_detail, :humidity, :precipitation,:panel0_name,:panel1_name, :panel2_name,:panel0_temp,:panel1_temp,
                        :panel2_temp,:panel0_short_detail,:panel1_short_detail,:panel2_short_detail, :panel0_precip, :panel1_precip,
                        :panel2_precip, :current_temp, :overnight_temp, :uv_index, :sunrise, :sunset, :overnight_precipitation, :feels_like

        include Modules::MassInitialize::InstanceMethods
    end

end
