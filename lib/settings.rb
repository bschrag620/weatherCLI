class Settings
    attr_accessor :zip_codes

    @@zip_codes = []

    def self.init
        if !File.file?(SETTINGS_PATH)
            File.open(SETTINGS_PATH, 'w') do |f|
                f.write(JSON.pretty_generate(self.class_hash))
            end
        end
        file = File.read(SETTINGS_PATH)
        settings_hash = JSON.parse(file)
        @@zip_codes = settings_hash["zip_codes"]
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

end
