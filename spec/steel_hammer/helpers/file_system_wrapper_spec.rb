require File.expand_path('spec/spec_helper')

describe FileSystemEntry do
  before(:each) { clean_temp }

  describe ".name" do
    context "when it is a file" do
      let(:a_file) do
        empty_file_at 'foo.bar.txt'
        inside_sandbox { FileSystemEntry.at 'foo.bar.txt' } 
      end 

      subject { a_file }

      its(:name} { should == "foo.bar" }
    end
  
    context "when it is a directory" do
      let(:a_directory) { inside_sandbox { FileSystemEntry.at '.' } } 

      subject { a_directory }

      its(:name} { should == "." }
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
        let(:a_file) do
          file_at 'file1.txt', "foobar\nbaz"
          inside_sandbox { FileSystemEntry.at 'file1.txt' }
        end

        subject { a_file }

        its(:type) { should == :file } #TODO move this somewhere else
        its(:contents) { should == "foobar\nbaz" }
        its(:content) { should == "foobar\nbaz" }
      end

      context "when it is empty" do
        let(:empty_file) do
          empty_file_at 'file2.txt'
          inside_sandbox { FileSystemEntry.at 'file2.txt' }
        end

        subject { empty_file }

        its(:content) { should == '' }
        its(:contents) { should == '' }
      end
    end

    context "when it is a directory" do
      let(:a_directory) do
        empty_file_at 'file1.txt'
        empty_file_at 'file2.rb'
        empty_folder_at 'folder1'
        inside_sandbox { FileSystemEntry.at '.' }
      end

      subject { a_directory }

      its(:type) { should == :directory } #TODO move this somewhere else
      its(:contents) { should_not be_empty }
      its(:content) { should_not be_empty }

      context "when listing files" do
        specify { subject.contents.select {|e| e.name == "file1"}.should_not be_empty }
        specify { subject.contents.select {|e| e.name == "file2"}.should_not be_empty }
      end

      context "when listing folders" do
        specify { subject.contents.select {|e| e.name == 'folder1'}.should_not be_empty }
      end
    end
  end
end
