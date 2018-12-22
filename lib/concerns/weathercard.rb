module WeatherCard
    module ClassMethods
        def reset
            self.all.clear
        end

    end

    module InstanceMethods
        def initialize(day)
            self.day = day
            self.class.all << self
        end

        def return_spaces(length)
            ' ' * (self.class.length - length)
        end

        def line_end
            self.class.horizontal * (self.class.length + 2)
        end

        def line_intermediate(value)
            "#{self.class.vertical}#{value}#{self.class.vertical}"
        end
    end
end
