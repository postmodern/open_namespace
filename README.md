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

* [extlib](http://github.com/datamapper/extlib) >= 0.9.14

## Install

    $ sudo gem install open_namespace

## License

(The MIT License)

Copyright (c) 2010 Hal Brodigan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
