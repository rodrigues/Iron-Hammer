require 'fileutils'

module TempFiles::InsideSandbox
  def empty_folder_at(path)
    FileUtils.mkpath path unless File.directory?(path)
  end

  def empty_file_at(path)
    guarantee(path)
    FileUtils.touch path
  end

  def file_at(path, contents)
    guarantee(path)
    File.open(path, 'w') {|f| f.write contents }
  end

  def guarantee(path)
    FileUtils.mkpath(File.dirname(path)) unless File.directory?(File.dirname(path))
  end

  def inside_sandbox
    Dir.chdir(self.sandbox_root) do
      yield if block_given?
    end
  end

  self.instance_methods(false).select {|x| x != :inside_sandbox }.each do |name|
    self.send(
      :alias_method, 
      "#{name}_outside_sandbox".to_sym, 
      name.to_sym)
    eval %[
      def #{name.to_s}(*args)
        self.inside_sandbox do
          self.#{name.to_s}_outside_sandbox(*args)
        end
      end
    ]
  end
end
