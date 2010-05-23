module SteelHammer
  def self.setup_autoload
    current_path = File.dirname(__FILE__)

    $LOAD_PATH.unshift(current_path)

    Dir["#{current_path}/*.rb"].each do 
      nil
    end
    autoload :Anvil, 'steel_hammer/anvil.rb'
    autoload :Helpers, 'steel_hammer/helpers.rb'
    autoload :StringAddons, 'steel_hammer/helpers/string_addons.rb'
    include Helpers
    include StringAddons
  end
  
  setup_autoload

  def include_class_methods
    name = []
    self.name.scan(/([A-Z][^A-Z]*)/) { |e| e.each { |x| name << "_#{x.downcase}" } } 

    require "#{name.inject('', &:+)[1..-1]}/class_methods".gsub(%r(/_|::_), '/')

    eval("include #{self.name}::ClassMethods")
  end
end
