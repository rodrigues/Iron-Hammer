require 'fileutils'

module TempFiles
  @@current_path = File.dirname(__FILE__)

  SHIT = 'shit__' # [S]teel [H]ammer [I]ntegration [T]ests

  def clean_temp
    FileUtils.rm_r self.sandbox_root if File.directory? self.sandbox_root
    FileUtils.mkpath self.sandbox_root
  end

  def temp_root
    @@temp_path ||= ENV['TEMP'] || 
      (File.directory?('/tmp') && '/tmp') || 
      (File.directory?('/var/tmp') && '/var/tmp') ||
      (raise RuntimeError.new 'could not locate temp folder')
  end

  def sandbox_root
    @@sandbox_root ||= File.join(self.temp_root, SHIT)
  end

  require File.join(@@current_path, 'temp_files', 'inside_sandbox.rb')
  include InsideSandbox
end
