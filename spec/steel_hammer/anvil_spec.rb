require File.expand_path('spec/spec_helper')

describe Anvil do
  it "should receive a path as starting point" do
    lambda { Anvil.at "." }.should_not raise_error
  end
end
