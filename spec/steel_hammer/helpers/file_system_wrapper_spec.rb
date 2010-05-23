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

  it "should be named after a file" do
    inside_sandbox do
      empty_file_at 'foo.bar.txt'
      entry = FileSystemEntry.at 'foo.bar.txt'
      entry.name.should == "foo.bar"
    end
  end

  context "extension of an entry" do
    before(:each) do
      clean_temp
    end

    it "should parse it correctly for files" do
      inside_sandbox do
        empty_file_at 'foo.bar.rb'
        entry = FileSystemEntry.at 'foo.bar.rb'
        entry.extension.should == "rb"
      end
    end

    it "should be nill in case of directories" do
      inside_sandbox do
        empty_folder_at 'foo.bar.rb'
        entry = FileSystemEntry.at 'foo.bar.rb'
        entry.extension.should be_nil
      end
    end
  end

  context "listing the contents of the current entry" do
    before(:each) do
      clean_temp
      empty_file_at 'file1.txt'
      empty_file_at 'file2.rb'
      empty_folder_at 'folder1'
      inside_sandbox { @entry = FileSystemEntry.at '.' }
    end

    it "should work if the current directory is not messed with" do
      inside_sandbox do
        @entry.contents.select {|e| e.name == 'file1' }.should_not be_empty
        @entry.contents.select {|e| e.name == 'file2' }.should_not be_empty
      end
    end

    it "should work even if the current directory is messed with" do
      Dir.chdir(File.dirname(__FILE__)) do
        @entry.contents.select {|e| e.name == 'file1' }.should_not be_empty
        @entry.contents.select {|e| e.name == 'file2' }.should_not be_empty
      end
    end

    it "should include the folders" do
      @entry.contents.select {|e| e.name == 'folder1' }.should_not be_empty
    end
  end
end
