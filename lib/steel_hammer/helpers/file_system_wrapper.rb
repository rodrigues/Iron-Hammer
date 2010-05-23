module SteelHammer::Helpers::FileSystemWrapper
  class FileSystemEntry
    attr_accessor :path

    def self.at(path)
      Dir[File.join(path, '*')].collect {|f| FileSystemEntry.new f }
    end

    def initialize(path)
      @path = path
    end

    def name
      @name ||= self.path.gsub(/\\+/, "/").split("/").last
    end
  end

  def self.included(base)
    autoload :FileSystemEntry, __FILE__
  end
end
