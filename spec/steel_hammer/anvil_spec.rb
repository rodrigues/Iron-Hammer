require File.expand_path('spec/spec_helper')

describe Anvil do
  describe '.at' do
    subject { @anvil = Anvil.at '.'}
    it { should be_an(Anvil) }
  end

  context "delegating methods to file system entry" do
    let(:anvil_with_mocked_fs) do
      (fs = mock(FileSystemEntry)).should_receive(:contents).and_return(:foo)
      (anvil = Anvil.at('location')).instance_eval { @file_system_entry = fs }
      anvil
    end

    #subject { @anvil = anvil_with_mocked_fs }

    #its(:contents) { should == :foo }

    specify { anvil_with_mocked_fs.contents.should == :foo }
  end
end
