require "./config/environment"

module WeatherCLI
  # Your code goes here...
    class SingleDay

        def self.display(zip='72703')
            # returns raw html from appropriate url
            html = GatherData::WeatherChannelToday.return_html(zip) 

            # returns applicable data to be used to create object
            weather_hash = ParseData::WeatherChannelToday.new(html).return_hash

            today = Forecast::Day.new(weather_hash)
            WeatherCard::SevenLines.new(today).display
        end
    end

    class FiveDay

        def self.display(zip='72703')
            html = GatherData::WeatherChannelFiveDay.return_html(zip)
            weather_hashes = ParseData::WeatherChannelFiveDay.new(html).return_hash
            WeatherCard::FiveLines.reset            
            weather_hashes.each do |weather|
                day = Forecast::Day.new(weather)
                WeatherCard::FiveLines.new(day)
            end
            WeatherCard::FiveLines.display_single_row
        end
    end

    class Hourly
        def self.display(zip='72703')
            html = GatherData::WeatherChannelHourly.return_html(zip)
            weather_hashes = ParseData::WeatherChannelHourly.new(html).return_hash
#            WeatherCard::Hourly.reset
        end
    end
                
end
