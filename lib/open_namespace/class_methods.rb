require 'rubygems'
require 'extlib'
require 'set'

module OpenNamespace
  module ClassMethods
    #
    # The namespace to search within.
    #
    # @return [String]
    #   The namespace to search for constants within.
    #
    def namespace
      @namespace ||= self.name
    end

    #
    # Sets the namespace to search within.
    #
    # @param [Module, Class, String] new_namespace
    #   The new namespace to search within.
    #
    # @return [String]
    #   The namespace to search within.
    #
    def namespace=(new_namespace)
      case new_namespace
      when Module, Class
        @namespace = new_namespace.name
      else
        @namespace = new_namespace.to_s
      end
    end

    #
    # The file path that represents the namespace.
    #
    # @return [String]
    #   The file path used to load constants into the namespace.
    #
    def namespace_root
      @namespace_root ||= self.name.to_const_path
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
    # Finds the RubyGems that contain files within the {#namespace_root}.
    #
    # @return [Array<Gem::Specification>]
    #   The RubyGem specs.
    #
    # @since 0.1.1
    #
    def namespace_gems
      unless defined?(@namespace_gems)
        namespace_dir = File.join('lib',self.namespace_root,'')

        loaded_gems = Gem.loaded_specs.values.select do |gem|
          gem.files.any? do |path|
            path.index(namespace_dir) == 0
          end
        end

        @namespace_gems = {}
        
        loaded_gems.each do |loaded_gem|
          @namespace_gems[loaded_gem.name] = loaded_gem

          loaded_gem.dependent_gems.each do |gems|
            gem = gems.first

            @namespace_gems[gem.name] = gem
          end
        end
      end

      return @namespace_gems
    end

    #
    # Provides the list of file-names that can be loaded by the namespace.
    #
    # @return [Set]
    #   The unique list of file-names under the namespace.
    #
    # @since 0.1.1
    #
    def namespace_files
      unless defined?(@namespace_files)
        @namespace_files = Set[]

        namespace_dir = File.join('lib',self.namespace_root,'')
        extract = Regexp.new(File.join('lib',self.namespace_root,'(.+)\.rb$'))

        namespace_gems.each_value do |gem|
          gem.files.each do |path|
            if path.index(namespace_dir) == 0
              @namespace_files << path.scan(extract).first[0]
            end
          end
        end
      end

      return @namespace_files
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
      name = name.to_s
      path = File.join(namespace_root,File.expand_path(File.join('',name)))

      begin
        require path
      rescue Gem::LoadError
        raise(e)
      rescue ::LoadError
        return nil
      end

      const_name = (self.namespace + '::' + name.to_const_string)

      begin
        return Object.full_const_get(const_name)
      rescue NameError
        return nil
      end
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
      require_const(name.to_s.to_const_path) || super(name)
    end
  end
end
