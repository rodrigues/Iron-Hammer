module IronHammer
  module Configuration

    def self.home
      return ENV['IRON_HAMMER_HOME'] if ENV['IRON_HAMMER_HOME']

      new_default_home
    end

    private
    
    def self.new_default_home
      home_dir = File.join(IronHammer::OS::Platform.home_directory, '.IronHammer')
      
      setup_home_dir(home_dir)
      
      home_dir
    end
    
    def self.setup_home_dir(home_dir)
      ENV['IRON_HAMMER_HOME'] = FileUtils.mkpath(home_dir)

      generate_config_files(home_dir)
      print_warning_message(home_dir)
    end
    
    def self.generate_config_files(home_dir)
      File.open(File.join(home_dir, 'rakefile.rb'), 'w') do |f|
        f.write default_rakefile_rb(home_dir)
      end

      File.open(File.join(home_dir, 'ivysettings.xml'), 'w') do |f|
        f.write default_ivysettings_xml(home_dir)
      end
    end

    def self.default_rakefile_rb(home_dir)
      <<EOF
require 'rubygems'

#VISUAL_STUDIO_PATH = ENV['VISUAL_STUDIO_PATH'] || 'C:\\Program Files\\Microsoft Visual Studio 9.0\\Common7\\IDE'
IVY_JAR = "#{File.join(home_dir, 'ivy.jar')}"
IVY_SETTINGS = "#{File.join(home_dir, 'ivysettings.xml')}"
#ORGANISATION = 'Your company'

require 'iron_hammer/tasks'
EOF
    end

    def self.default_ivysettings_xml(home_dir)
      <<EOF
<ivysettings>
  <settings defaultResolver="default" />
  <caches defaultCacheDir="#{home_dir}/Ivy/Cache"/>
  <resolvers>
    <filesystem name="default">
      <ivy pattern="#{home_dir}/Ivy/Repository/[organisation]/[module]/ivys/ivy-[revision].xml"/>
      <artifact pattern="#{home_dir}/Ivy/Repository/[organisation]/[module]/[type]s/[artifact]-[revision].[ext]"/>
    </filesystem>
  </resolvers>
</ivysettings>
EOF
    end

    def self.print_warning_message(home_dir)
      puts %Q{
IRON_HAMMER_HOME environment variable not found! Generating default config on #{home_dir}.
You'll need to download apache ivy from http://ant.apache.org/ivy/download.cgi
and copy ivy-x.x.x.jar to #{File.join(home_dir, 'ivy.jar')}.
You can also edit #{File.join(home_dir, 'rakefile.rb')} and change any settings you want.
      }
    end
  end
end
