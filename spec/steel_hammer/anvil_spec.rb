require File.expand_path('spec/spec_helper')

describe Anvil do
  context "starting point" do
    it "should receive a path as starting point" do
      lambda { Anvil.at "." }.should_not raise_error
    end

    it "should return an anvil" do
      Anvil.at(".").should be_an(Anvil)
    end
  end

  it "should provide a list with all files" do
    fs = mock(FileSystemEntry)
    FileSystemEntry.
      should_receive(:at).
      with('location').
      and_return(fs)

    anvil = Anvil.at "location"

    fs.
      should_receive(:contents).
      and_return(:expected_result)

    anvil.contents.should == :expected_result
  end
end
