require 'solution'
require 'spec'

describe Solution do

    it "should setup the solution with the given argument" do
        Solution.new(:name => "MySolution").name.should(be_eql "MySolution")
        Solution.new(:name => "MySolution").solution.should(be_eql "MySolution.sln")
    end
    
    it "should not allow the creation of a solution without a name" do
        lambda { Solution.new }.should(raise_error ArgumentError)
    end

end