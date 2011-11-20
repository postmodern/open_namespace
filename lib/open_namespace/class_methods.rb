module OpenNamespace
  module ClassMethods
    #
    # The file path that represents the namespace.
    #
    # @return [String]
    #   The file path used to load constants into the namespace.
    #
    def namespace_root
      @namespace_root ||= OpenNamespace.const_path(self.name)
    end

    #
    # Sets the file path of the namespace.
    #
    # @param [String] new_path
    #   The new path of the namespace.
    #
    # @return [String]
    #   The file path used to load constants into the namespace.
    #
    def namespace_root=(new_path)
      @namespace_root = new_path.to_s
    end

    #
    # Requires the file and finds the newly defined constant.
    #
    # @param [String, Symbol] name
    #   The name or sub-path of the file.
    #
    # @return [Class, Module, nil]
    #   The constant loaded from the file. If +nil+ is returned, then either
    #   the file could not be loaded or the required constant could not be
    #   found.
    #
    # @example Loading a constant.
    #   require_const :helper
    #   # => Fully::Qualiffied::Namespace::Helper
    #
    # @example Loading a constant from a sub-path.
    #   require_const 'network/helper'
    #   # => Fully::Qualified::Namespace::Network::Helper
    #
    def require_const(name)
      require_file(name)

      return const_search(name)
    end

    #
    # Requires the file with the given name, within the namespace root
    # directory.
    #
    # @param [Symbol, String] name
    #   The name of the file to require.
    #
    # @return [true, nil]
    #   Returns `true` if the file was successfully loaded, returns `nil`
    #   on a `LoadError` exception.
    #
    # @raise [Gem::LoadError]
    #   A dependency needed by the file could not be satisfied by RubyGems.
    #
    # @since 0.3.0
    #
    def require_file(name)
      name = name.to_s
      path = File.join(namespace_root,File.expand_path(File.join('',name)))

      begin
        require path
      rescue Gem::LoadError => e
        raise(e)
      rescue ::LoadError
        return nil
      end

      return true
    end

    #
    # Checks if a constant is defined or attempts loading the constant.
    #
    # @param [String] name
    #   The name of the constant.
    #
    # @return [Boolean]
    #   Specifies whether the constant is defined.
    #
    def const_defined?(name)
      if super(name)
        true
      else
        # attempt to load the file that might have the constant
        require_file(OpenNamespace.const_path(name))

        # check for the constant again
        return super(name)
      end
    end

    #
    # Finds the exact constant.
    #
    # @param [String] name
    #   The name of the constant.
    #
    # @return [Object, nil]
    #   The exact constant or `nil` if the constant could not be found.
    #
    # @since 0.4.0
    #
    def const_lookup(name)
      OpenNamespace.const_lookup(self,name)
    end

    #
    # Finds the constant with a name similar to the given file name.
    #
    # @param [Symbol, String] file_name
    #   The file name that represents the constant.
    #
    # @return [Object, nil]
    #   Returns the found constants, or `nil` if a `NameError` exception
    #   was encountered.
    #
    # @since 0.3.0
    #
    def const_search(file_name)
      OpenNamespace.const_search(self,file_name)
    end

    protected

    #
    # Provides transparent access to require_const.
    #
    # @param [Symbol] name
    #   The name of the constant to load.
    #
    # @return [Class, Module]
    #   The loaded constant.
    #
    # @raise [NameError]
    #   Could not load or find the required constant.
    #
    # @see require_const.
    #
    def const_missing(name)
      if self.const_defined?(name)
        # get the exact constant name that was requested
        return self.const_get(name)
      end
      
      return super(name)
    end
  end
end
