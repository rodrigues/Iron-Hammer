puts "foo"
module SteelHammer
  class Anvil
    module ClassMethods
      def self.included(klass)
        klass.extend self
      end

      def at(path)

      end
    end

    include ClassMethods
  end
end
