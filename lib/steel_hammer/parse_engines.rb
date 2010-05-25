module SteelHammer::ParseEngines
  steel_hammer_include_csproj_parser
  #@@current_path = File.dirname(__FILE__)

  #def self.included(base)
  #  require "#{@@current_path}/helpers/string_addons"
  #  include StringAddons

  #  Dir["#{@@current_path}/parse_engines/*.rb"].each do |f|
  #    eval "autoload :#{f.steel_hammer_class_name}, '#{f}'"

  #    inclusion = "include #{f.steel_hammer_class_name}"

  #    eval(inclusion)
  #    base.instance_eval(inclusion)
  #  end
  #end
end
