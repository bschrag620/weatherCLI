module WeatherCard

# a class for creating weather cards to be easily and consistently displayed
# each card type will be unique to the data it displays
# 
    
    class FiveLines
#                    -------------
#                    |day        |
#                    |H:xxx L:xxx|
#                    |shortdetail|
#                    |xx wind    |
#                    |h:xxx p:xxx|
#                    -------------
        attr_accessor :day      #=> receives day object       
        @@all = []
        @@length = 11
        @@horizontal = '-'.colorize(:light_yellow)
        @@vertical = '|'.colorize(:light_yellow)

        extend WeatherCard::ClassMethods
        include WeatherCard::InstanceMethods

        def self.length
            @@length
        end
    
        def self.horizontal
            @@horizontal
        end

        def self.vertical
            @@vertical
        end

        def self.all
            @@all
        end


        def line_one
            line_end
        end

        def line_two
            str_length = day.day.length
            remainder = @@length - str_length
            spaces = ' ' * (remainder)
            "#{@@vertical}#{day.day}#{spaces}#{@@vertical}"
        end

        def line_three
            str_length = day.min.length + day.max.length + 4
            remainder = @@length - str_length
            spaces = ' ' * (remainder)
            "#{@@vertical}H:#{day.max.colorize(:light_red)}#{spaces}L:#{day.min.colorize(:light_blue)}#{@@vertical}"
        end

        def line_four
            str_length = day.short_detail.length
            if str_length < @@length
                remainder = @@length - str_length
                spaces = ' ' * (remainder)
            else
                spaces = ''
            end
            "#{@@vertical}#{day.short_detail.slice(0..10)}#{spaces}#{@@vertical}"
        end

        def line_five
            str_length = day.wind_magnitude.length + day.wind_direction.length + day.wind_units.length
            remainder = @@length - str_length
            spaces = ' ' * (remainder - 1)
            "#{@@vertical}#{day.wind_direction} #{day.wind_magnitude}#{day.wind_units}#{spaces}#{@@vertical}"
        end

        def line_six
            str_length = [day.precipitation.length,3].min + [day.humidity.length,3].min + 4
            remainder = @@length - str_length
            spaces = ' ' * (remainder)
            "#{@@vertical}h:#{day.humidity.slice(0..2)}#{spaces}p:#{day.precipitation.slice(0..2)}#{@@vertical}"
        end
    
        def line_seven
            line_one
        end

        def self.display
            row1 = ''
            row2 = ''
            row3 = ''
            row4 = ''
            row5 = ''
            row6 = ''
            row7 = ''
            @@all.each do |day|
                row1 += day.line_one
                row2 += day.line_two
                row3 += day.line_three
                row4 += day.line_four
                row5 += day.line_five
                row6 += day.line_six
                row7 += day.line_seven
            end
            puts row1
            puts row2
            puts row3
            puts row4
            puts row5
            puts row6
            puts row7                
        end
    end

    class SevenLines
#       1            ---------------------------------
#       2            |  dayText         short_detail |
#       3            | H:xxx  L:xxx      Current:xxx |
#       4            | UV:xxxxxxx    sunrise:xxxxxxx |
#       5            | wind:xxxxxxxx  sunset:xxxxxxx |
#       6            | humidity:xxxx     precip:xxxx |
#       7            | panel1 low:xxx                |
#       8            | panel1 precip:xxx             |
#       9            ---------------------------------
        attr_accessor :day
        @@all = []
        @@length = 31
        @@horizontal = '-'.colorize(:light_yellow)
        @@vertical = '|'.colorize(:light_yellow)
        

        extend WeatherCard::ClassMethods
        include WeatherCard::InstanceMethods        
        
# :day, :panel_1_name, :current_temp, :panel_1_temp, :panel_2_temp, :short_detail, panel_1_short_detail, :panel_2_short_detail
# :precipitation, :panel_1_precip, :panel_2_precip, :max, :min, :wind_direction, :wind_magnitude, :wind_units,
# :long_detail, :humidity, :uv_index, :sunrise, :sunset

        def self.length
            @@length
        end
    
        def self.horizontal
            @@horizontal
        end

        def self.vertical
            @@vertical
        end

        def self.all
            @@all
        end
        
        def initialize(day)
            self.day = day
        end

        def line1
            line_end
        end

        def line2
            str_length = day.day.length + day.short_detail.length
            spaces = return_spaces(str_length)
            str = "#{day.day}#{spaces}#{day.short_detail}"
            line_intermediate(str)
        end

        def line3
            str_length = day.max.length + day.min.length + day.current_temp.length + 16
            spaces = return_spaces(str_length)
            str = "H:#{day.max.colorize(:light_red)}  L:#{day.min.colorize(:light_blue)}#{spaces}Currently:#{day.current_temp}"
            line_intermediate(str)
        end

        def line4
            str_length = day.uv_index.length + day.sunrise.length + 11
            spaces = return_spaces(str_length)
            str = "UV:#{day.uv_index}#{spaces}feels like:#{day.feels_like}"
            line_intermediate(str)
        end

        def line5
            str_length = day.wind_magnitude.length + day.wind_direction.length + day.wind_units.length + day.sunset.length + 13
            spaces = return_spaces(str_length)
            str = "wind:#{day.wind_direction}#{day.wind_magnitude}#{day.wind_units}#{spaces}sunrise #{day.sunrise}"
            line_intermediate(str)
        end

        def line6
            str_length = day.humidity.length + day.sunset.length + 16
            spaces = return_spaces(str_length)
            str = "humidity:#{day.humidity}#{spaces}sunset #{day.sunset}"
            line_intermediate(str)
        end

        def line7
            str_length = day.panel1_name.length + day.panel1_temp.length + 5
            spaces = return_spaces(str_length)
            str = "#{day.panel1_name} low:#{day.panel1_temp}#{spaces}"
            line_intermediate(str)
        end

        def line8
            str_length = day.panel1_name.length + day.panel1_precip.length + 8
            spaces = return_spaces(str_length)
            str = "#{day.panel1_name} precip:#{day.panel1_precip}#{spaces}"
            line_intermediuate(str)
        end

        def line9
            line1
        end

        def display
            puts line1
            puts line2
            puts line3
            puts line4
            puts line5
            puts line6
            detail
            puts line9
        end

        def detail
            words = day.long_detail.split(' ')
            while words.length > 0 do
                new_string = ''
                while new_string.length + words[0].length < @@length do
                    new_string += words.shift
                    new_string += ' '
                    break if words == []
                end
                spaces = return_spaces(new_string.length)
                new_string = "#{new_string.colorize(:light_yellow)}#{spaces}"                
                puts line_intermediate(new_string)
            end
        end
    end

    class Hourly
#                    -------------
#                    |dayTime    |
#                    |temp feels |
#                    |shortdetail|
#                    |xx wind    |
#                    |h:xxx p:xxx|
#                    -------------


        attr_accessor :day      #=> receives day object       
        @@all = []
        @@length = 11
        @@horizontal = '-'.colorize(:light_yellow)
        @@vertical = '|'.colorize(:light_yellow)

        extend WeatherCard::ClassMethods
        include WeatherCard::InstanceMethods

        def self.length
            @@length
        end
    
        def self.horizontal
            @@horizontal
        end

        def self.vertical
            @@vertical
        end

        def self.all
            @@all
        end

        def line1
            line_end
        end

        def line2
            str_length = day.day.length
            spaces = return_spaces(str_length)
            str = "#{day.day.colorize(:light_green)}#{spaces}"
            line_intermediate(str)
        end

        def line3
            str_length = day.current_temp.length + 6
            spaces = return_spaces(str_length)
            str = "curr: #{day.current_temp}#{spaces}"
            line_intermediate(str)
        end

        def line4
            str_length = day.feels_like.length + 7
            spaces = return_spaces(str_length)
            str = "feels: #{day.feels_like}#{spaces}"
            line_intermediate(str)
        end

        def line5
            str_length = [day.short_detail.length, 11].min
            spaces = return_spaces(str_length)
            str = "#{day.short_detail[0..10]}#{spaces}"
            line_intermediate(str)
        end
    
        def line6
            str_length = day.wind_magnitude.length
            spaces = return_spaces(str_length)
            str = "#{day.wind_magnitude}#{spaces}"
            line_intermediate(str)
        end
    
        def line7
            str_length = day.humidity.length + day.precipitation.length + 4
            spaces = return_spaces(str_length)
            str = "h:#{day.humidity}#{spaces}p:#{day.precipitation}"
            line_intermediate(str)
        end
    
        def line8
            line1
        end

        def self.display
            beginning = 0
            final = 5
            n = (self.length / 6.0 + 0.5).to_i
            n.times do
                row1 = ''
                row2 = ''
                row3 = ''
                row4 = ''
                row5 = ''
                row6 = ''
                row7 = ''
                row8 = ''
                self.all[beginning..final].each do |weather|
                    row1 += weather.line1
                    row2 += weather.line2
                    row3 += weather.line3
                    row4 += weather.line4
                    row5 += weather.line5
                    row6 += weather.line6
                    row7 += weather.line7
                    row8 += weather.line8
                end
                beginning += 6
                final += 6
                puts row1
                puts row2
                puts row3
                puts row4
                puts row5
                puts row6
                puts row7
                puts row8
            end
        end
    end
end
