module SteelHammer::Anvil::ClassMethods
  module Methods
    def at(path)
      Anvil.new path
    end
  end

  def self.included(klass)
    klass.extend Methods
  end
end
