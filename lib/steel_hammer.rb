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
    include_special_stuff :class_methods
  end

  def include_instance_methods
    include_special_stuff :instance_methods
  end

  def include_special_stuff(kind)
    require "#{self.name.steel_hammer_path}/#{kind.to_s.downcase}"
    eval("include #{self.name}::#{kind.to_s.steel_hammer_class_name}")
  end
end
