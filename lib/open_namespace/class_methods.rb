module OpenNamespace
  module ClassMethods
    #
    # The file path that represents the namespace.
    #
    # @return [String]
    #   The file path used to load constants into the namespace.
    #
    def namespace_root
      @namespace_root ||= OpenNamespace.constant_path(self.name)
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
      rescue Gem::LoadError
        raise(e)
      rescue ::LoadError
        return nil
      end

      return true
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
      names = file_name.to_s.split(/[:\/]+/)
      scope = self

      until names.empty?
        name = names.shift

        # strip any dashes or underscores
        name.tr!('_-','')

        # perform a case insensitive search
        const_pattern = /^#{name}$/i

        # grep for the constant
        const_name = scope.constants.find { |name| name =~ const_pattern }

        # the constant search failed
        return nil unless const_name

        scope = scope.const_get(const_name)
      end

      return scope
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
      file_name = OpenNamespace.constant_path(name)

      if require_file(file_name)
        #
        # If const_missing is being called, the constant is not present yet.
        # Therefor, only check for the constant if the file was
        # successfully loaded by require_file.
        #
        if self.const_defined?(name)
          # get the exact constant name that was requested
          return self.const_get(name)
        end
      end
      
      return super(name)
    end
  end
end
