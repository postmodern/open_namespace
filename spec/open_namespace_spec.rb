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

    it "should have the same namespace as the module name" do
      @module.namespace.should == 'Classes::SimpleNamespace'
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

    it "should load constants transparently via const_missing" do
      const = @module::ConstantTwo

      const.class.should == Class
      const.name.should == 'Classes::SimpleNamespace::ConstantTwo'
    end

    it "should return nil on LoadError exceptions" do
      const = @module.require_const(:constant_not_found)

      const.should be_nil
    end

    it "should return nil on NameError exceptions" do
      const = @module.require_const(:bad_constant)

      const.should be_nil
    end
  end

  describe "custom namespace" do
    before(:all) do
      @module = Classes::CustomNamespace
    end

    it "should have the same namespace as the module name" do
      @module.namespace.should == 'Classes::CustomNamespace::Custom'
    end

    it "should have the same namespace root as the module's directory" do
      @module.namespace_root.should == File.join('classes','custom')
    end

    it "should load constants into the namespace" do
      @module.require_const :constant_one

      @module.should be_const_defined('Custom')
      @sub_module = @module.const_get('Custom')

      @sub_module.should be_const_defined('ConstantOne')
    end

    it "should find loaded constants in the namespace" do
      const = @module.require_const(:constant_one)

      const.class.should == Class
      const.name.should == 'Classes::CustomNamespace::Custom::ConstantOne'
    end

    it "should load constants transparently via const_missing" do
      const = @module::ConstantTwo

      const.class.should == Class
      const.name.should == 'Classes::CustomNamespace::Custom::ConstantTwo'
    end

    it "should return nil on LoadError exceptions" do
      const = @module.require_const(:constant_not_found)

      const.should be_nil
    end

    it "should return nil on NameError exceptions" do
      const = @module.require_const(:bad_constant)

      const.should be_nil
    end
  end
end
