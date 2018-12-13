module Modules
    module MassInitialize
        module InstanceMethods
            def initialize(args)
                args.each do |key, value|
                    self.send("#{key}=", value)
                end
            end
        end

    end
end
