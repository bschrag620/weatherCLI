# module for housing the various classes of data to gather
# each class will have a unique url. The ReturnHTML module has the methods for
# retreiving the data

module GatherData
    class WeatherChannelFiveDay
        @@url = 'https://weather.com/weather/5day/l/'

        extend ReturnHTML::ClassMethods

        def self.url
            @@url
        end
    end

    class WeatherChannelToday
        @@url = 'https://weather.com/weather/today/l/'

        extend ReturnHTML::ClassMethods

        def self.url
            @@url
        end
    end

    class WeatherChannelHourly
        @@url = 'https://weather.com/weather/hourbyhour/l/'

        extend ReturnHTML::ClassMethods

        def self.url
            @@url
        end

    end
end


