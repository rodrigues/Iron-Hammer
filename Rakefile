require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/iron_hammer'

Hoe.plugin :newgem

$hoe = Hoe.spec 'iron_hammer' do
  self.developer 'Mozair Alves do Carmo Junior', 'macskeptic@gmail.com'
  self.developer 'Lucas Cavalcanti', 'lucasmrtuner@gmail.com'
  self.developer 'Adolfo Sousa', 'adolfosousa@gmail.com'

  self.post_install_message = File.read('PostInstall.txt')
  self.rubyforge_name       = self.name
  self.extra_deps           = [['rubyzip2','>= 2.0.1'],
                               ['builder', '>= 2.1.2']]
  self.extra_dev_deps       = [['rake', '>= 0.8.7'],
                               ['rspec', '>= 1.3.0'],
                               ['newgem', '>= 1.5.3']]
  self.version              = '1.1.1'
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]

