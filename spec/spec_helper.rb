$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'steel_hammer'
require 'spec'
require 'spec/autorun'

Dir[File.join(File.dirname(__FILE__), 'support', '*.rb')].
  select { |f| !File.directory?(f) }.
  each { |f| require f }

include SteelHammer
include TempFiles

Spec::Runner.configure do |config|
  
end
