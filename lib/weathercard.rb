module WeatherCard

# a class for creating weather cards to be easily and consistently displayed
# each card type will be unique to the data it displays
# 
    
    class FiveLine
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

        def initialize(day)
            self.day = day
            @@all << self
        end

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

        def self.reset
            @@all = []
        end

        def self.all
            @@all
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
end
