require File.expand_path('spec/spec_helper')

describe FileSystemEntry do
  it "should be named after the starting point directory" do
    inside_sandbox do
      entry = FileSystemEntry.at '.'
      entry.name.should == "."
    end
  end

  it "should list all the files in the directory" do
    empty_file_at 'file1.txt'
    empty_file_at 'file2.txt'

    puts FileSystemEntry.instance_methods
    inside_sandbox do
      entry = FileSystemEntry.at '.'
      entry.contents.select {|e| e.name == 'file1.txt' }.should_not be_empty
      entry.contents.select {|e| e.name == 'file2.txt' }.should_not be_empty
    end
  end
end
