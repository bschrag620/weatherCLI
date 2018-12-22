# test file for weather CLI

require './lib/weatherCLI'

include Menus

menu = Menus.main_menu
while true
    menu = menu.retreive_selection
end

