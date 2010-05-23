module SteelHammer::Helpers::FileSystemWrapper
  class FileSystemEntry
    attr_accessor :path

    def self.at(path)
      @current_directory = Dir.pwd
      FileSystemEntry.new path
    end

    def initialize(path)
      @path = path
    end

    def name
      @name ||= self.path.gsub(/\\+/, "/").split("/").last
    end

    def contents
      Dir[File.join(@path, '*')].collect {|f| FileSystemEntry.new f }
    end
  end

  def self.included(base)
    autoload :FileSystemEntry, __FILE__
  end
end
