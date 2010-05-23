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
    context "when it is a file" do
      before(:each) do
        clean_temp
        file_at 'file1.txt', "foobar\nbaz"
        inside_sandbox { @file = FileSystemEntry.at 'file1.txt' }
      end

      it "should have a 'file' type" do
        @file.type.should == :file  
      end

      it "should return its contents" do
        @file.contents.should == "foobar\nbaz"
      end

      it "should return an empty string when the file is empty" do
        empty_file_at 'file2.txt'
        inside_sandbox do
          FileSystemEntry.at('file2.txt').content.should == ''
        end
      end
    end

    context "when it is a directory" do
      before(:each) do
        clean_temp
        empty_file_at 'file1.txt'
        empty_file_at 'file2.rb'
        empty_folder_at 'folder1'
        inside_sandbox { @directory = FileSystemEntry.at '.' }
      end

      it "should have a 'directory' type" do
        @directory.type.should == :directory  
      end

      it "should return an empty list when it is empty" do
        inside_sandbox do
          FileSystemEntry.at('folder1').contents.should be_empty
        end
      end

      it "should work if the current directory is not messed with" do
        inside_sandbox do
          @directory.contents.select {|e| e.name == 'file1' }.should_not be_empty
          @directory.contents.select {|e| e.name == 'file2' }.should_not be_empty
        end
      end

      it "should work even if the current directory is messed with" do
        Dir.chdir(File.dirname(__FILE__)) do
          @directory.contents.select {|e| e.name == 'file1' }.should_not be_empty
          @directory.contents.select {|e| e.name == 'file2' }.should_not be_empty
        end
      end

      it "should include the folders" do
        @directory.contents.select {|e| e.name == 'folder1' }.should_not be_empty
      end
    end
  end
end
