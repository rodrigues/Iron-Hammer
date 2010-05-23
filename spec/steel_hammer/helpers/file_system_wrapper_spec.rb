require File.expand_path('spec/spec_helper')

describe FileSystemEntry do
   it "should list all the files of a directory" do
     empty_file_at 'file1.txt'
     empty_file_at 'file2.txt'
     inside_sandbox do
       contents = FileSystemWrapper.contents_of('.')
       contents.select {|e| e.name == 'file1.txt' }.should_not be_empty
       contents.select {|e| e.name == 'file2.txt' }.should_not be_empty
     end
   end
end
