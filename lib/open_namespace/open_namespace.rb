require_relative 'class_methods'

module OpenNamespace
  def self.included(base)
    base.extend ClassMethods
  end

  #
  # Maps a constant name to a likely file path.
  #
  # @param [String, Symbol] name
  #   The constant name.
  #
  # @return [String]
  #   The file path that the constant is likely to be defined within.
  #
  # @since 0.3.0
  #
  # @api semipublic
  #
  def self.const_path(name)
    path = name.to_s.dup

    # back-ported from extlib's String#to_const_path
    path.gsub!(/::/,'/')

    # back-ported from extlib's String#snake_case
    unless path.match(/\A[A-Z]+\z/)
      path.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      path.gsub!(/([a-z])([A-Z])/, '\1_\2')
    end

    path.downcase!
    return path
  end

  #
  # Finds the exact constant.
  #
  # @param [Module, Class] scope
  #   The scope to begin searching within.
  #
  # @param [String] name
  #   The name of the constant.
  #
  # @return [Object, nil]
  #   The exact constant or `nil` if the constant could not be found.
  #
  # @since 0.4.0
  #
  # @api semipublic
  #
  def self.const_lookup(scope,name)
    names = name.split('::')

    until names.empty?
      begin
        scope = scope.const_get(names.shift)
      rescue NameError
        return nil
      end
    end

    return scope
  end

  #
  # Finds the constant with a name similar to the given file name.
  #
  # @param [Module, Class] scope
  #   The scope to begin searching within.
  #
  # @param [Symbol, String] file_name
  #   The file name that represents the constant.
  #
  # @return [Object, nil]
  #   Returns the found constants, or `nil` if a `NameError` exception
  #   was encountered.
  #
  # @since 0.4.0
  #
  # @api semipublic
  #
  def self.const_search(scope,file_name)
    names = file_name.to_s.split(/[:\/]+/)

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
end
