# module for class methods of returning HTML

module ReturnHTML
    module ClassMethods

        def return_html(zip)
            full_url = "#{self.url}#{zip}"
            begin
                open(full_url, &:read)
            rescue OpenURI::HTTPError
                puts "#{zip} is not found on weather.com. Consider removing it from your list.".colorize(:light_red)
            end
        end
    end
end
