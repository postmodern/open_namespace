require 'spec_helper'
require 'open_namespace'

require 'classes/simple_namespace'
require 'classes/custom_namespace'

describe OpenNamespace do
  it "should have a VERSION constant" do
    expect(OpenNamespace.const_defined?('VERSION')).to be(true)
  end

  context "default namespace" do
    subject { Classes::SimpleNamespace }

    it "should have the same namespace root as the module's directory" do
      expect(subject.namespace_root).to eq(
        File.join('classes','simple_namespace')
      )
    end

    it "should load constants into the namespace" do
      subject.require_const :constant_one

      expect(subject).to be_const_defined('ConstantOne')
    end

    it "should find loaded constants in the namespace" do
      const = subject.require_const(:constant_one)

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::SimpleNamespace::ConstantOne')
    end

    it "should find constants with odd capitalization" do
      const = subject.require_const(:odd_constant)

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::SimpleNamespace::ODDConstant')
    end

    it "should load constants via sub-paths" do
      subject.require_const(File.join('sub','constant_four'))

      expect(subject).to be_const_defined('Sub')

      sub = subject.const_get('Sub')

      expect(sub).to be_const_defined('ConstantFour')
    end

    it "should find constants loaded via sub-paths" do
      const = subject.require_const(File.join('sub','constant_four'))

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::SimpleNamespace::Sub::ConstantFour')
    end

    it "should return nil on LoadError exceptions" do
      const = subject.require_const(:constant_not_found)

      expect(const).to be(nil)
    end

    it "should return nil on NameError exceptions" do
      const = subject.require_const(:bad_constant)

      expect(const).to be(nil)
    end

    it "should attempt loading the constant when calling const_defined?" do
      expect(subject.const_defined?('ConstantThree')).to be(true)
    end

    it "should load constants transparently via const_missing" do
      const = subject::ConstantTwo

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::SimpleNamespace::ConstantTwo')
    end

    it "should raise a NameError exception const_missing fails" do
      expect {
        subject::BadConstant
      }.to raise_error(NameError)
    end
  end

  context "custom namespace" do
    subject { Classes::CustomNamespace }

    it "should have the same namespace root as the module's directory" do
      expect(subject.namespace_root).to eq(File.join('classes','custom'))
    end

    it "should load constants into the namespace" do
      subject.require_const(:constant_one)

      expect(subject).to be_const_defined('ConstantOne')
    end

    it "should find loaded constants in the namespace" do
      const = subject.require_const(:constant_one)

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::CustomNamespace::ConstantOne')
    end

    it "should find constants with odd capitalization" do
      const = subject.require_const(:odd_constant)

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::CustomNamespace::ODDConstant')
    end

    it "should load constants via sub-paths" do
      subject.require_const File.join('sub','constant_four')

      expect(subject).to be_const_defined('Sub')

      sub = subject.const_get('Sub')

      expect(sub).to be_const_defined('ConstantFour')
    end

    it "should find constants loaded via sub-paths" do
      const = subject.require_const(File.join('sub','constant_four'))

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::CustomNamespace::Sub::ConstantFour')
    end

    it "should return nil on LoadError exceptions" do
      const = subject.require_const(:constant_not_found)

      expect(const).to be_nil
    end

    it "should return nil on NameError exceptions" do
      const = subject.require_const(:bad_constant)

      expect(const).to be_nil
    end

    it "should attempt loading the constant when calling const_defined?" do
      expect(subject.const_defined?('ConstantThree')).to be(true)
    end

    it "should load constants transparently via const_missing" do
      const = subject::ConstantTwo

      expect(const.class).to be(Class)
      expect(const.name).to eq('Classes::CustomNamespace::ConstantTwo')
    end

    it "should raise a NameError exception const_missing fails" do
      expect {
        subject::BadConstant
      }.to raise_error(NameError)
    end
  end
end
