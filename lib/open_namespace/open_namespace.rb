require 'open_namespace/class_methods'

module OpenNamespace
  def self.included(base)
    base.extend ClassMethods
  end
end
