load 'spec/spec_helper.rb'
include TempFiles
clean_temp
empty_file_at 'asdasd.txt'
file_at 'zxczxc.txt', "foo\nbar"
inside_sandbox do
  FileUtils.touch 'within'
end
