class Settings
    attr_accessor :zip_codes

    @@zip_codes = []

    def self.init
        if !File.file?(SETTINGS_PATH)
            self.save_zips
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

    def self.save_zips
        File.open(SETTINGS_PATH, 'w') do |f|
            f.write(JSON.pretty_generate(@@zip_codes))
        end
    end

    def self.add_zip(zip)
        @@zip_codes << zip
    end

    def self.remove_zip(zip)
        @@zip_codes.delete(zip)
        self.save_zips
    end

end
