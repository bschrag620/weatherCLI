module ParseData
    class WeatherChannelFiveDay
        attr_accessor :file, :html
        
        def initialize(file)
            self.file = file
            self.html = Nokogiri::HTML(self.file.read)
        end

        def return_hash
            # available instance variable for forecast class are =>
            # :day, :date, :max, :min, :temperature_units, :wind_direction, :wind_magnitude, :wind_units, :date, :short_detail, :long_detail, :humidity
            days.collect.with_index do |day, i|
                puts i
                {   :day => days[i],
                    :date => dates[i],
                    :max => max_temps[i],
                    :min => min_temps[i],
                    :wind_direction => wind_directions[i],
                    :wind_magnitude => wind_magnitudes[i],
                    :wind_units => wind_units[i],
                    :short_detail => short_details[i],
                    :long_detail => long_details[i],
                    :humidity => humidities[i]}
            end
        end
                    
        def days
            self.html.css('body span.date-time').collect do |day|
                day.text
            end
        end
    
        def dates
            self.html.css('body span.day-detail').collect do |date|
                date.text
            end
        end

        def forecast_temps
            self.html.css('tbody td.temp div')
        end

        def max_temps
            forecast_temps.collect do |temp|
                temp.css('span')[0].text
            end
        end

        def min_temps
            forecast_temps.collect do |temp|
                temp.css('span')[2].text
            end
        end
   
        def forecast_wind
            self.html.css('tbody td.wind span')
        end

        def wind_direction(wind_text)
            wind_text.split(' ')[0]
        end

        def wind_magnitude(wind_text)
            wind_text.split(' ')[1]
        end

        def wind_unit(wind_text)
            wind_text.split(' ')[2]
        end

        def wind_values
            forecast_wind.collect do |wind|                
                wind.text
            end
        end

        def wind_directions
            wind_values.collect do |wind|
                wind_direction(wind)
            end
        end

        def wind_magnitudes
            wind_values.collect do |wind|
                wind_magnitude(wind)
            end
        end
        
        def wind_units
            wind_values.collect do |wind|
                wind_unit(wind)
            end
        end

        def long_details
            self.html.css('tbody td.description').collect do |detail|
                detail.attribute('title').value
            end
        end

        def short_details
            self.html.css('tbody td.description').collect do |detail|
                detail.text
            end
        end

        def humidities
            values = []
            self.html.css('tbody td.humidity span span').each do |humidity|
                if humidity.text != "%"
                    values << humidity.text
                end
            end
        values
        end
    end
end
