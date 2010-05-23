module SteelHammer::Helpers::FileSystemWrapper
  class FileSystemEntry
    attr_accessor :path

    def self.at(path)
      FileSystemEntry.new path
    end

    def initialize(path)
      @current_directory = Dir.pwd
      @path = path
    end

    def name
      @name ||= self.path.gsub(/\\+/, "/").split("/").last
    end

    def contents
      Dir[File.join(@path, '*')].collect {|f| FileSystemEntry.new f }
    end

    self.instance_methods(false).select {|x| x != :inside_sandbox }.each do |name|
      self.send(
        :alias_method, 
        "#{name}_with_unsafe_current_dir".to_sym, 
        name.to_sym)
      eval %[
        def #{name.to_s}(*args)
          Dir.chdir(@current_directory) do
            self.#{name.to_s}_with_unsafe_current_dir(*args)
          end
        end
      ]
    end
  end

  def self.included(base)
    autoload :FileSystemEntry, __FILE__
  end
end
