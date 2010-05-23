module SteelHammer::Helpers
  @@current_path = File.dirname(__FILE__)

  def self.included(base)
    require "#{@@current_path}/helpers/string_addons"
    include StringAddons

    Dir["#{@@current_path}/helpers/*.rb"].each do |f|
      class_name = f.steel_hammer_class_name

      eval "autoload :#{f.steel_hammer_class_name}, '#{f}'"

      inclusion = "include #{f.steel_hammer_class_name}"

      eval(inclusion) unless class_name == 'StringAddons'
      base.instance_eval(inclusion) unless class_name == 'StringAddons'
    end
  end
end
