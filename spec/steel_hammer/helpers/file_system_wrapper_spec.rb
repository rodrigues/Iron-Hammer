require File.expand_path('spec/spec_helper')

describe FileSystemEntry do
  before(:each) { clean_temp }

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

  describe "#extension" do
    context "when it is a file" do
      let(:a_file) do
        empty_file_at 'foo.bar.rb'
        entry = inside_sandbox { FileSystemEntry.at 'foo.bar.rb' }
      end

      subject { a_file }

      its(:extension) { should == "rb" }
    end

    context "when it is a directory" do
      let(:a_directory) do
        empty_folder_at 'foo.bar.rb'
        entry = inside_sandbox { FileSystemEntry.at 'foo.bar.rb' }
      end

      subject { a_directory }

      its(:extension) { should be_nil }
    end
  end

  describe "#contents" do
    context "when it is a file" do
      context "when it has contents" do
        let(:single_file) do
          clean_temp
          file_at 'file1.txt', "foobar\nbaz"
          inside_sandbox { FileSystemEntry.at 'file1.txt' }
        end

        subject { single_file }

        its(:type) { should == :file }
        its(:contents) { should == "foobar\nbaz" }
        its(:content) { should == "foobar\nbaz" }
      end

      context "when it is empty" do
        let(:empty_file) do
          clean_temp
          empty_file_at 'file2.txt'
          inside_sandbox { FileSystemEntry.at 'file2.txt' }
        end

        subject { empty_file }

        its(:content) { should == '' }
        its(:contents) { should == '' }
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
