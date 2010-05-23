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
    anvil = Anvil.at "location"

    FileSystemWrapper.
      should_receive(:all).
      with("location").
      and_return(:expected_result)

    anvil.contents.should == :expected_result
  end
end
