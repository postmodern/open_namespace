require 'spec_helper'

shared_examples_for 'Namespace Files' do
    before(:all) do
      @simple_gem = mock(
        'simple_namespace gem',
        :name => 'simple-namespace',
        :files => [
          'lib/classes/simple_namespace/constant_one.rb',
          'lib/classes/simple_namespace/constant_two.rb',
          'lib/classes/simple_namespace/bad_constant.rb',
          'lib/classes/simple_namespace/sub/constant_four.rb',
          'lib/classes/simple_namespace/bogus.txt',
          'lib/classes/outside.rb'
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
          'lib/classes/custom/sub/constant_four.rb',
          'lib/classes/custom/bogus.txt',
          'lib/classes/outside.rb'
        ],
        :dependent_gems => []
      )

      @module.stub!(:namespace_gems).and_return(
        'simple-namespace' => @simple_gem,
        'custom-namespace' => @custom_gem
      )
    end

    it "should strip the '.rb' extension from paths" do
      @module.namespace_files.should_not include('constant_one.rb')
    end

    it "should include files within the namespace_root" do
      @module.namespace_files.should include('constant_one')
      @module.namespace_files.should include('constant_two')
      @module.namespace_files.should include('bad_constant')
    end

    it "should include sub-files within the namespace_root" do
      @module.namespace_files.should include('sub/constant_four')
    end

    it "should ignore paths not ending in '.rb'" do
      @module.namespace_files.should_not include('bogus')
      @module.namespace_files.should_not include('bogus.txt')
    end

    it "should ignore paths outside of the namespace_root" do
      @module.namespace_files.should_not include('outside')
    end
end
