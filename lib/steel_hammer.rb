module SteelHammer
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  autoload :Anvil, 'steel_hammer/anvil/class_methods.rb'
  autoload :Anvil, 'steel_hammer/anvil.rb'

  def include_class_methods
    name = []
    self.name.scan(/([A-Z][^A-Z]*)/) { |e| e.each { |x| name << "_#{x.downcase}" } } 

    require "#{name.inject('', &:+)[1..-1]}/class_methods".gsub(%r(/_|::_), '/')

    eval("include #{self.name}::ClassMethods")
  end
end
