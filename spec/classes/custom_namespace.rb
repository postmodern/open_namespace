require 'open_namespace'

module Classes
  module CustomNamespace
    include OpenNamespace

    self.namespace_root = File.join('classes','custom')
  end
end
