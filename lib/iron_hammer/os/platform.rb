module IronHammer
  module OS
    module Platform
      def self.is_mac?
        RUBY_PLATFORM.downcase.include?("darwin")
      end

      def self.is_windows?
         RUBY_PLATFORM.downcase.include?("mswin")
      end

      def self.is_linux?
         RUBY_PLATFORM.downcase.include?("linux")
      end
      
      def self.home_directory
        is_windows? ? ENV['USERPROFILE'] : File.expand_path('~/')
      end
      
      def self.directory_separator
        is_windows? ? '\\' : '/'
      end
    end
  end
end