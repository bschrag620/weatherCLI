require 'nokogiri'
require 'gem_menu'
require 'open-uri'
require 'json'
require './lib/parse_data'
require './lib/concerns/modules'
require './lib/concerns/weathercard'
require './lib/concerns/return_html'
require './lib/concerns/menus'
require './lib/weatherCLI/version'
require './lib/forecast'
require './lib/weathercard'
require './lib/settings'
require './lib/gather_data'


SETTINGS_PATH = './config/settings'
ZIP_MATCH = Regexp.new('^[0-9]{5}$')
Settings.init
