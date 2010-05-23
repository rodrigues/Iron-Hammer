module SteelHammer
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  autoload :Anvil, 'steel_hammer/anvil/class_methods.rb'
  autoload :Anvil, 'steel_hammer/anvil.rb'

  def include_class_methods
    name = []
    "#{self.name.gsub('::', '/')}".
      scan(/([A-Z][^A-Z]*)/) do |e| 
        e.each { |x| name << "_#{x.downcase}" } 
      end
    require "#{name.inject('', &:+)[1..-1]}/class_methods".gsub('/_', '/')

    eval("include #{self.name}::ClassMethods")
  end
end
