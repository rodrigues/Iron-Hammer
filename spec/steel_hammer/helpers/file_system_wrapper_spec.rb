require File.expand_path('spec/spec_helper')

describe FileSystemEntry do
  before(:each) do
    clean_temp
  end

  it "should be named after the starting point directory" do
    inside_sandbox do
      entry = FileSystemEntry.at '.'
      entry.name.should == "."
    end
  end

  context "listing the contents of the current entry" do
    before(:each) do
      empty_file_at 'file1.txt'
      empty_file_at 'file2.txt'
      empty_folder_at 'folder1'
      inside_sandbox { @entry = FileSystemEntry.at '.' }
    end

    it "should work if the current directory is not messed with" do
      inside_sandbox do
        @entry.contents.select {|e| e.name == 'file1.txt' }.should_not be_empty
        @entry.contents.select {|e| e.name == 'file2.txt' }.should_not be_empty
      end
    end

    it "should work even if the current directory is messed with" do
      Dir.chdir(File.dirname(__FILE__)) do
        @entry.contents.select {|e| e.name == 'file1.txt' }.should_not be_empty
        @entry.contents.select {|e| e.name == 'file2.txt' }.should_not be_empty
      end
    end

    it "should include the folders" do
      @entry.contents.select {|e| e.name == 'folder1' }.should_not be_empty
    end
  end
end
