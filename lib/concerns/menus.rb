module Menus
    def choose_forecast(zip)
        entries = []
        entries << GemMenu::Entry.new("5 day forecast", method(:display_5_day), {:parameters => zip})
        entries << GemMenu::Entry.new("Single day detail", method(:display_single_detail), {:parameters => zip})
        entries << GemMenu::Entry.new("Hourly", method(:display_hourly), {:parameters => zip})
        optional = {:previous_menu => method(:main_menu)}
        GemMenu::Menu.new("Choose forecast to view", entries, optional_args=optional)
    end

    def main_menu
        zips = Settings.zip_codes
        entries = []
        zips.each do |zip|
            entries << GemMenu::Entry.new(zip, method(:choose_forecast), optional_args = {:parameters => zip})
        end
        entries << GemMenu::Entry.new("Add zip code", method(:add_zip))
        entries << GemMenu::Entry.new("Remove zip code", method(:remove_zip))
        GemMenu::Menu.new("Choose a zipcode to view forecast", entries)
    end

    def remove_zip
        entries = []
        Settings.zip_codes.each do |zip|
            entries << GemMenu::Entry.new(zip, method(:delete_zip), optional_args={:parameters => zip})
        end
        GemMenu::Menu.new("Select zipcode to remove", entries, optional_args={:previous_menu => method(:main_menu)})
    end

    def display_5_day(zip)
        WeatherCLI::FiveDay.display(zip)
        choose_forecast(zip)
    end

    def display_single_detail(zip)
        WeatherCLI::SingleDay.display(zip)
        choose_forecast(zip)
    end

    def display_hourly(zip)
        WeatherCLI::Hourly.display(zip)
        choose_forecast(zip)
    end

    def add_zip
        puts "Please enter the zip code:".colorize(:light_green)
        zip = gets.strip
        Settings.add_zip(zip)
        main_menu
    end

    def delete_zip(zip)
        Settings.remove_zip(zip)
        remove_zip
    end
end
