class Settings
    attr_accessor :zip_codes

    @@zip_codes = []

    def self.init
        if !File.file?(SETTINGS_PATH)
            self.save_zips
        end
        file = File.read(SETTINGS_PATH)
        settings_hash = JSON.parse(file)
        puts "settings_hash: #{settings_hash}"
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
end
