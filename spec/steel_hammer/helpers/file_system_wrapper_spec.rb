require File.expand_path('spec/spec_helper')

describe FileSystemWrapper do
   it "should list the contents of a directory" do
     empty_file_at 'file1.txt'
     empty_file_at 'file2.txt'
   end
end
