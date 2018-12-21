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

        def line_one
            @@horizontal * (@@length + 2)
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

        def display
            puts line_one
            puts line_two
            puts line_three
            puts line_four
            puts line_five
            puts line_six
            puts line_seven
        end

        def self.display_single_row
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
        @@length = 31
        @@horizontal = '-'.colorize(:light_yellow)
        @@vertical = '|'.colorize(:light_yellow)        
        
# :day, :panel_1_name, :current_temp, :panel_1_temp, :panel_2_temp, :short_detail, panel_1_short_detail, :panel_2_short_detail
# :precipitation, :panel_1_precip, :panel_2_precip, :max, :min, :wind_direction, :wind_magnitude, :wind_units,
# :long_detail, :humidity, :uv_index, :sunrise, :sunset
        
        def return_spaces(length)
            ' ' * (@@length - length)
        end
        
        def initialize(day)
            self.day = day
        end

        def line1
            @@horizontal * (@@length + 2)
        end

        def line2
            str_length = day.day.length + day.short_detail.length + 2
            remainder = @@length - str_length
            spaces = ' ' * remainder
            "#{@@vertical} #{day.day}#{spaces}#{day.short_detail} #{@@vertical}"
        end

        def line3
            str_length = day.max.length + day.min.length + day.current_temp.length + 18
            spaces = return_spaces(str_length)
            "#{@@vertical} H:#{day.max.colorize(:light_red)}  L:#{day.min.colorize(:light_blue)}#{spaces}Currently:#{day.current_temp} #{@@vertical}"
        end

        def line4
            str_length = day.uv_index.length + day.sunrise.length + 13
            spaces = return_spaces(str_length)
            "#{@@vertical} UV:#{day.uv_index}#{spaces}feels like:#{day.feels_like} #{@@vertical}"
        end

        def line5
            str_length = day.wind_magnitude.length + day.wind_direction.length + day.wind_units.length + day.sunset.length + 15
            spaces = return_spaces(str_length)
            "#{@@vertical} wind:#{day.wind_direction}#{day.wind_magnitude}#{day.wind_units}#{spaces}sunrise #{day.sunrise} #{@@vertical}"
        end

        def line6
            str_length = day.humidity.length + day.sunset.length + 18
            spaces = return_spaces(str_length)
            "#{@@vertical} humidity:#{day.humidity}#{spaces}sunset #{day.sunset} #{@@vertical}"
        end

        def line7
            str_length = day.panel1_name.length + day.panel1_temp.length + 7
            spaces = return_spaces(str_length)
            "#{@@vertical} #{day.panel1_name} low:#{day.panel1_temp}#{spaces} #{@@vertical}"
        end

        def line8
            str_length = day.panel1_name.length + day.panel1_precip.length + 10
            spaces = return_spaces(str_length)
            "#{@@vertical} #{day.panel1_name} precip:#{day.panel1_precip}#{spaces} #{@@vertical}"
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
                while new_string.length + words[0].length < @@length - 2 do
                    new_string += words.shift
                    new_string += ' '
                    break if words == []
                end
                spaces = return_spaces(new_string.length + 2)
                new_string = "#{@@vertical} #{new_string.colorize(:light_yellow)}#{spaces} #{@@vertical}"
                
                puts new_string
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

        def line1
            
        end
    end
end
