module Csprojs
  @@current_path = File.expand_path(File.dirname(__FILE__))
  Dir.chdir(@@current_path) { @@list = Dir["csprojs/*"] }

  @@list.each do |f|
    define_method(
      "#{f.gsub(%r!^.*/(.+)\.([^\.]*)$!, '\1' + '_' + '\2')}_contents") do
      Dir.chdir(@@current_path) do
        File.read f 
      end
    end
  end
end
