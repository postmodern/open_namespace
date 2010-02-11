# OpenNamespace

* [github.com/postmodern/open_namespace](http://github.com/postmodern/open_namespace)
* [github.com/postmodern/open_namespace/issues](http://github.com/postmodern/open_namespace/issues)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

OpenNamespace allows namespaces to require and find class and modules from
other gems. Using OpenNamespace you can make a `Plugins` namespace be able
to load plugin modules/classes from other gems.

## Features

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

    # explicit loading of constants
    Project::Plguins.require_const :foo_bar
    # => Project::Plugins::FooBar

    # explicitly loading constants via sub-paths
    Project::Plguins.require_const 'templates/erb'
    # => Project::Plugins::Templates::Erb

    # implicit loading of constants via const_missing
    Project::Plugins::Other
    # => Project::Plugins::Other

Loading constants from alternate namespaces / directories:

    module Project
      module UI
        module CommandLine
	  include OpenNamespace

          self.namespace = 'Projects::UI::CommandLine::Commands'
	  self.namespace_root = File.join('project','ui','command_line','commands')
	end
      end
    end

    Project::UI::CommandLine.require_const :help
    # => Project::UI::CommandLine::Commands::Help

## Requirements

* [extlib](http://gemcutter.org/gems/extlib) >= 0.9.14

## Install

    $ sudo gem install open-namespace

## License

See {file:LICENSE.txt} for license information.

