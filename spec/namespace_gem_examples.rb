require 'spec_helper'

shared_examples_for 'Namespace Gem' do
  before(:all) do
    @simple_gem = mock(
      'simple_namespace gem',
      :name => 'simple-namespace',
      :files => [
        'lib/classes/simple_namespace/constant_one.rb',
        'lib/classes/simple_namespace/constant_two.rb',
        'lib/classes/simple_namespace/bad_constant.rb',
        'lib/classes/simple_namespace/sub/constant_four.rb'
      ],
      :dependent_gems => []
    )

    @custom_gem = mock(
      'custom_namespace gem',
      :name => 'custom-namespace',
      :files => [
        'lib/classes/custom/constant_one.rb',
        'lib/classes/custom/constant_two.rb',
        'lib/classes/custom/bad_constant.rb',
        'lib/classes/custom/sub/constant_four.rb'
      ],
      :dependent_gems => []
    )
  end

  it "should provide a list of file-names within the namespace root" do
    @module.should_receive(:namespace_gems).once.and_return(
      'simple-namespace' => @simple_gem,
      'custom-namespace' => @custom_gem
    )

    @module.namespace_files.should == Set[
      'constant_one',
      'constant_two',
      File.join('sub','constant_four'),
      'bad_constant'
    ]
  end
end
