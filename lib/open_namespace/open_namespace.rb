require 'open_namespace/class_methods'

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
  # @api private
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
end
