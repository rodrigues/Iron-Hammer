module SteelHammer::Helpers
  @@current_path = File.dirname(__FILE__)

  def self.included(base)
    require "#{@@current_path}/helpers/string_addons"
    include StringAddons
  end
end
