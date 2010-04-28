require 'open_namespace/version'

require 'spec_helper'
require 'classes/simple_namespace'
require 'classes/custom_namespace'

describe OpenNamespace do
  it "should have a VERSION constant" do
    OpenNamespace.const_defined?('VERSION').should == true
  end

  describe "default namespace" do
    before(:all) do
      @module = Classes::SimpleNamespace
    end

    it "should have the same namespace root as the module's directory" do
      @module.namespace_root.should == File.join('classes','simple_namespace')
    end

    it "should load constants into the namespace" do
      @module.require_const :constant_one

      @module.should be_const_defined('ConstantOne')
    end

    it "should find loaded constants in the namespace" do
      const = @module.require_const(:constant_one)

      const.class.should == Class
      const.name.should == 'Classes::SimpleNamespace::ConstantOne'
    end

    it "should load constants via sub-paths" do
      @module.require_const File.join('sub','constant_four')

      @module.should be_const_defined('Sub')
      @sub = @module.const_get('Sub')

      @sub.should be_const_defined('ConstantFour')
    end

    it "should find constants loaded via sub-paths" do
      const = @module.require_const(File.join('sub','constant_four'))

      const.class.should == Class
      const.name.should == 'Classes::SimpleNamespace::Sub::ConstantFour'
    end

    it "should return nil on LoadError exceptions" do
      const = @module.require_const(:constant_not_found)

      const.should be_nil
    end

    it "should return nil on NameError exceptions" do
      const = @module.require_const(:bad_constant)

      const.should be_nil
    end

    it "should load constants transparently via const_missing" do
      const = @module::ConstantTwo

      const.class.should == Class
      const.name.should == 'Classes::SimpleNamespace::ConstantTwo'
    end

    it "should raise a NameError exception const_missing fails" do
      lambda {
        @module::BadConstant
      }.should raise_error(NameError)
    end
  end

  describe "custom namespace" do
    before(:all) do
      @module = Classes::CustomNamespace
    end

    it "should have the same namespace root as the module's directory" do
      @module.namespace_root.should == File.join('classes','custom')
    end

    it "should load constants into the namespace" do
      @module.require_const :constant_one
      @module.should be_const_defined('ConstantOne')
    end

    it "should find loaded constants in the namespace" do
      const = @module.require_const(:constant_one)

      const.class.should == Class
      const.name.should == 'Classes::CustomNamespace::ConstantOne'
    end

    it "should load constants via sub-paths" do
      @module.require_const File.join('sub','constant_four')

      @module.should be_const_defined('Sub')
      @sub = @module.const_get('Sub')

      @sub.should be_const_defined('ConstantFour')
    end

    it "should find constants loaded via sub-paths" do
      const = @module.require_const(File.join('sub','constant_four'))

      const.class.should == Class
      const.name.should == 'Classes::CustomNamespace::Sub::ConstantFour'
    end

    it "should return nil on LoadError exceptions" do
      const = @module.require_const(:constant_not_found)

      const.should be_nil
    end

    it "should return nil on NameError exceptions" do
      const = @module.require_const(:bad_constant)

      const.should be_nil
    end

    it "should load constants transparently via const_missing" do
      const = @module::ConstantTwo

      const.class.should == Class
      const.name.should == 'Classes::CustomNamespace::ConstantTwo'
    end

    it "should raise a NameError exception const_missing fails" do
      lambda {
        @module::BadConstant
      }.should raise_error(NameError)
    end
  end
end
