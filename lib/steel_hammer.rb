module SteelHammer
  def self.setup_autoload
    current_path = File.dirname(__FILE__)

    $LOAD_PATH.unshift(current_path)

    autoload :Helpers, 'steel_hammer/helpers.rb'
    autoload :StringAddons, 'steel_hammer/helpers/string_addons.rb'
    include Helpers
    include StringAddons

    Dir["#{current_path}/*.rb"].each do |f|
      autoload f.steel_hammer_class_name.to_sym, f
    end
    #autoload :Anvil, 'steel_hammer/anvil.rb'
  end
  
  setup_autoload

  def include_class_methods
    name = []
    self.name.scan(/([A-Z][^A-Z]*)/) { |e| e.each { |x| name << "_#{x.downcase}" } } 

    require "#{name.inject('', &:+)[1..-1]}/class_methods".gsub(%r(/_|::_), '/')

    eval("include #{self.name}::ClassMethods")
  end
end
