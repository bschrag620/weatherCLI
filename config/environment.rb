require './lib/parse_data'
require './lib/concerns/modules'
require './lib/concerns/weathercard'
require './lib/concerns/return_html'
require 'nokogiri'
require 'gem_menu'
require 'open-uri'
require './lib/weatherCLI/version'
require './lib/forecast'
require './lib/weathercard'
require './lib/settings'
require './lib/gather_data'
require 'json'

SETTINGS_PATH = './config/settings'
TEST_PATH = './fixtures/weather.html'
