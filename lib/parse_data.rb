# module for sifting through a Nokogiri object to retrieve the desired properties

module ParseData
    class WeatherChannelFiveDay
        attr_accessor :html
        
        def initialize(doc)
            self.html = Nokogiri::HTML(doc)
        end

        def return_hash
            # available instance variable for forecast class are =>
            # :day, :date, :max, :min, :wind_direction, :wind_magnitude, :wind_units, :date, :short_detail, :long_detail, :humidity
            days.collect.with_index do |day, i|
                {   :day => days[i],
                    :date => dates[i],
                    :max => max_temps[i],
                    :min => min_temps[i],
                    :wind_direction => wind_directions[i],
                    :wind_magnitude => wind_magnitudes[i],
                    :wind_units => wind_units[i],
                    :short_detail => short_details[i],
                    :long_detail => long_details[i],
                    :humidity => humidities[i],
                    :precipitation => precips[i]}
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

        def precips
            self.html.css('tbody td.precip div').collect do |precip|
                precip.text
            end
        end
    end

    class WeatherChannelToday
        attr_accessor :html
        
        def initialize(doc)
            self.html = Nokogiri::HTML(doc)
        end

        def return_hash
                {   :day => panel0_text,
                    :panel1_name => panel1_text,
                    :panel2_name => panel2_text,
                    :current_temp => current_temp,
                    :panel1_temp => panel1_temp,
                    :panel2_temp => panel2_temp,
                    :short_detail => panel0_short_detail,
                    :panel1_short_detail => panel1_short_detail,
                    :panel2_short_detail => panel2_short_detail,
                    :precipitation => panel0_precip,
                    :panel1_precip => panel1_precip,
                    :panel2_precip => panel2_precip,
                    :max => max,
                    :min => min,
                    :wind_direction => wind_direction,
                    :wind_magnitude => wind_magnitude,
                    :wind_units => wind_units,
                    :long_detail => long_detail,
                    :humidity => humidity,
                    :uv_index => uv_index,
                    :sunrise => sunrise,
                    :sunset => sunset,
                    :feels_like => feels_like}
        end

        def feels_like
            self.html.css('div.today_nowcard div.today_nowcard-feels span.deg-feels').text
        end

        def current_temp
            self.html.css('div.today_nowcard div.today_nowcard-temp span').text
        end

        def max
            self.html.css('div.today_nowcard-hilo span.deg-hilo-nowcard')[0].text
        end

        def min
            self.html.css('div.today_nowcard-hilo span.deg-hilo-nowcard')[1].text
        end

        def wx_detail
            self.html.css('div.looking-ahead.panel-footer li.wx-detail span.wx-detail-text span.wx-detail-value')
        end
        
        def wind
            wx_detail[0].text
        end

        def wind_units
            wind.split(' ')[2]
        end

        def wind_direction
            wind.split(' ')[0]
        end

        def wind_magnitude
            wind.split(' ')[1]
        end

        def humidity
            wx_detail[1].text
        end

        def uv_index
            wx_detail[2].text.sub(' ', '')
        end

        def sunrise
            wx_detail.css('span#dp0-details-sunrise').text.sub(' ', '')
        end

        def sunset
            wx_detail.css('span#dp0-details-sunset').text.sub(' ', '')
        end

        def long_detail
            self.html.css('div.dp-details span#dp0-details-narrative').text
        end

        def panel0_precip
            self.html.css('div#daypart-0 span.precip-val').text
        end

        def panel1_precip
            self.html.css('div#daypart-1 span.precip-val').text
        end

        def panel2_precip
            self.html.css('div#daypart-2 span.precip-val').text
        end

        def panel0_short_detail
            self.html.css('div#daypart-0 span.today-daypart-wxphrase').text
        end

        def panel1_short_detail
            self.html.css('div#daypart-1 span.today-daypart-wxphrase').text
        end

        def panel2_short_detail
            self.html.css('div#daypart-2 span.today-daypart-wxphrase').text
        end

        def panel0_text
            self.html.css('div#daypart-0 span.today-daypart-title').text
        end

        def panel1_text
            self.html.css('div#daypart-1 span.today-daypart-title').text
        end

        def panel2_text
            self.html.css('div#daypart-2 span.today-daypart-title').text
        end

        def panel0_temp
            self.html.css('div#daypart-0 div.today-daypart-temp').text
        end

        def panel1_temp
            self.html.css('div#daypart-1 div.today-daypart-temp').text
        end

        def panel2_temp
            self.html.css('div#daypart-2 div.today-daypart-temp').text
        end
    end

    class WeatherChannelHourly
        attr_accessor :html
        
        def initialize(doc)
            self.html = Nokogiri::HTML(doc)
        end

        def return_hash
            names.collect.with_index do |name, i|
                {   :day => name,
                    :current_temp => temps[i],
                    :feels_like => feels[i],
                    :wind_magnitude => winds[i],
                    :humidity => humidities[i],
                    :precipitation => precips[i],
                    :short_detail => short_details[i]
                }
            end
        end

        def names
            days.zip(times).collect do |day, time|
                "#{day}#{time}".gsub(' ', '')
            end
        end

        def values(value)
            self.html.css("tbody td.#{value} span").collect do |item|
                item.text
            end
        end

        def short_details
            a = values('hidden-cell-sm.description')
            a
        end

        def temps
            values('temp')
        end

        def feels
            values('feels')
        end

        def precips
            items = values('precip')
            items.each do |item|
                if item.length < 2
                    items.delete(item)
                end
            end
            items
        end

        def humidities
            items = values('humidity')
            items.each do |item|
                if item.length < 2
                    items.delete(item)
                end
            end
            items
        end

        def times
            self.html.css('tbody div.hourly-time span').collect do |time|
                time.text
            end
        end
    
        def days
            self.html.css('tbody div.hourly-date').collect do |day|               
                day.text
            end
        end

        def winds
            values('wind')
        end     
    end
end
