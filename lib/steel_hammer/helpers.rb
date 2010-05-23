module SteelHammer::Helpers
  @@current_path = File.dirname(__FILE__)

  def self.included(base)
    require "#{@@current_path}/helpers/string_addons"
    include StringAddons

    Dir["#{@@current_path}/helpers/*.rb"].each do |f|
      next if f.steel_hammer_class_name == 'StringAddons'

      eval "autoload :#{f.steel_hammer_class_name}, '#{f}'"

      inclusion = "include #{f.steel_hammer_class_name}"

      eval(inclusion)
      base.instance_eval(inclusion)
    end
  end
end
