require File.expand_path('spec/spec_helper')

describe StringAddons do
  it "should return the class name based on its file" do
    example = "steel_hammer/anvil.rb"
    example.steel_hammer_class_name.should == "Anvil"
  end

  it "should return the path based on the class name" do
    example = "SteelHammer::Anvil"
    example.steel_hammer_path.should == "steel_hammer/anvil"
  end
end
