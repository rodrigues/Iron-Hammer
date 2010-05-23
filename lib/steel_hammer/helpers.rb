module SteelHammer::Helpers
  @@current_path = File.dirname(__FILE__)

  def self.included(base)
    require "#{@@current_path}/helpers/string_addons"
    include StringAddons

    Dir["#{@@current_path}/helpers/*.rb"].each do |f|
      class_name = f.steel_hammer_class_name

      eval(%[
        autoload :#{f.steel_hammer_class_name}, '#{f}'
        include #{f.steel_hammer_class_name}
      ]) unless class_name == 'StringAddons'
    end
  end
end
