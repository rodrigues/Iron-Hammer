require 'zip/zipfilesystem'

class Package
  attr_accessor :root
  
  def initialize path_to_root
    @root = path_to_root  
  end
  
  def package file='package.zip'
		Dir.chdir(@root) { zip_current_working_folder_into_this file }
  end
  
  private 
  def zip_current_working_folder_into_this package_name
    Zip::ZipFile::open(package_name, true) do |zip_file|
			Dir[File.join('**', '*')].each do |file|
				zip_file.add(file, file)
			end
		end
	end
end unless defined? Package