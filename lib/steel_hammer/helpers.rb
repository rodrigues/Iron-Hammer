module SteelHammer::Helpers
  @@current_path = File.dirname(__FILE__)

  def self.included(base)
    require "#{@@current_path}/helpers/string_addons"
    include StringAddons

    #Dir["#{@@current_path}/helpers*.rb"].each do |f|
    #  eval "autoload :#{f.steel_hammer_class_name}, '#{f}'"
    #  eval "include #{f.steel_hammer_class_name}"
    #end
  end
end
