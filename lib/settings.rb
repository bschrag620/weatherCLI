class Settings
    attr_accessor :zip_codes

    @@zip_codes = []

    def self.init
        puts "\n***\tWelcome to WeatherGem\t***".colorize(:light_blue)

        if !File.file?(SETTINGS_PATH)
            self.save
        end
        file = File.read(SETTINGS_PATH)
        settings_hash = JSON.parse(file)
        @@zip_codes = settings_hash["zip_codes"]
        if @@zip_codes.length == 0
            self.no_zips
        end
    end

    def self.class_hash
        {"zip_codes" => @@zip_codes}
    end

    def self.zip_codes
        @@zip_codes
    end

    def self.reset_zips
        @@zip_code = []
    end

    def self.save
        File.open(SETTINGS_PATH, 'w') do |f|
            f.write(JSON.pretty_generate(self.class_hash))
        end
    end

    def self.add_zip(zip)
        @@zip_codes << zip
        self.save
    end

    def self.remove_zip(zip)
        @@zip_codes.delete(zip)
        self.save
    end

    def self.no_zips
        puts "There are no saved zip codes, please enter at least 1 zip code, \nor if more than 1 use a comma to separate:".colorize(:light_green)
        zips = gets.strip
        zips.split(',').each do |zip|
            if ZIP_MATCH.match(zip.strip)
                self.add_zip(zip.strip)
            else
                puts "#{zip.strip.colorize(:light_red)} not recognized as a valid zip code."
            end
        end
        self.init
    end
end
