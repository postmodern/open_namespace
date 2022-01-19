# OpenNamespace

* [Source](https://github.com/postmodern/open_namespace)
* [Issues](https://github.com/postmodern/open_namespace/issues)
* [Documentation](http://rubydoc.info/gems/open_namespace/frames)

## Description

OpenNamespace allows namespaces to require and find classes and modules from
RubyGems. Using OpenNamespace you can make a `Plugins` module able to
load plugin modules/classes from other gems.

## Features

* Provides implicit loading of constants via `const_defined?`.
* Provides implicit loading of constants via `const_missing`.
* Provides explicit loading of constants via `require_const`.

## Examples

Explicit and implicit loading of constants:

    require 'open_namespace'

    module Project
      module Plugins
        include OpenNamespace
      end
    end

    # explicitly load constants
    Project::Plguins.require_const :foo_bar
    # => Project::Plugins::FooBar

    # explicitly load constants with odd capitalization
    Project::Plugins.require_const :tcp_session
    # => Project::Plugins::TCPSession

    # explicitly load constants via sub-paths
    Project::Plguins.require_const 'templates/erb'
    # => Project::Plugins::Templates::Erb

    # implicitly load constants via const_missing
    Project::Plugins::Other
    # => Project::Plugins::Other

Loading constants from alternate namespace root directories:

    module Project
      module UI
        module CommandLine
          module Commands
            include OpenNamespace

            self.namespace_root = File.join('project','ui','command_line','commands')
          end
        end
      end
    end

    Project::UI::CommandLine::Commands.require_const :help
    # => Project::UI::CommandLine::Commands::Help

## Install

    $ gem install open_namespace

## License

Copyright (c) 2010-2012 Hal Brodigan

See {file:LICENSE.txt} for license information.
