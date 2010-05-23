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

    def fullname_without_path
      @path.gsub(/\\+/, "/").split("/").last
    end

    def type
      File.directory?(@path) ?
        :directory :
        :file
    end

    def name
      @name ||= self.fullname_without_path 
      
      return @name if self.type == :directory
      
      @name.gsub!(%r{^(.+)\.[^\.]*$}, '\1')
    end

    def extension
      return nil if self.type == :directory

      @extension ||= self.
        fullname_without_path.
        gsub(%r{^.+\.([^\.]*)$}, '\1')
    end

    def directory?
      self.type == :directory
    end

    def contents
      return File.read @path unless self.directory?
      Dir[File.join(@path, '*')].collect {|f| FileSystemEntry.new f }
    end

    self.instance_methods(false).select {|x| x != :inside_sandbox }.each do |name|
      self.send(
        :alias_method, 
        "with_unsafe_current_dir_#{name}".to_sym, 
        name.to_sym)
      eval %[
        def #{name.to_s}(*args)
          Dir.chdir(@current_directory) do
            self.with_unsafe_current_dir_#{name.to_s} *args
          end
        end
      ]
    end

    alias :content :contents
  end

  def self.included(base)
    autoload :FileSystemEntry, __FILE__
  end
end
