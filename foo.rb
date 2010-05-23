load 'spec/spec_helper.rb'
include TempFiles
clean_temp
empty_file_at 'asdasd.txt'
empty_file_at 'yyyy/asdasd.txt'
empty_file_at 'xxxx/asdasd.txt'
file_at 'zxczxc.txt', "foo\nbar"
empty_folder_at 'xfqwe/asdxcb'
inside_sandbox do
  FileUtils.touch 'within'
end
puts InsideSandbox.instance_methods(false)
