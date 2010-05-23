module SteelHammer
  @@current_path = File.dirname(__FILE__)
  $LOAD_PATH.unshift(@@current_path)

  def self.include_helpers
    autoload :Helpers, 'steel_hammer/helpers.rb'
    include Helpers
  end

  def self.included(base)
    Dir["#{@@current_path}/*.rb"].each do |f|
      eval "autoload :#{f.steel_hammer_class_name}, '#{f}'"
    end
  end
  
  include_helpers

  def include_class_methods
    #name = []
    #self.name.scan(/([A-Z][^A-Z]*)/) { |e| e.each { |x| name << "_#{x.downcase}" } } 

    #require "#{name.inject('', &:+)[1..-1]}/class_methods".gsub(%r(/_|::_), '/')

    require "#{self.name.steel_hamer_path}/class_methods"
    eval("include #{self.name}::ClassMethods")
  end
end
