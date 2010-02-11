require 'open_namespace/version'

require 'spec_helper'

describe OpenNamespace do
  it "should have a VERSION constant" do
    OpenNamespace.const_defined?('VERSION').should == true
  end
end
