$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'steel_hammer'
require 'spec'
require 'spec/autorun'
require 'temp_files'

include SteelHammer
include TempFiles

Spec::Runner.configure do |config|
  
end
