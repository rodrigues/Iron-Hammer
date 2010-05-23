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

  def steel_hammer_include(what)
    require "#{self.name.steel_hammer_path}/#{what.to_s.downcase}"
    eval("include #{self.name}::#{what.to_s.steel_hammer_class_name}")
  end

  def method_missing(name, *args, &block)
    super unless /^steel_hammer_include_/ =~ name
    steel_hammer_include name.to_s.gsub("steel_hammer_include_", '')
  end
end
