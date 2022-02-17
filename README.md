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
* Can auto-load other sub-gems (ex: `foo-bar`) from the main gem's namespace
  (ex: `Foo`).

## Examples

Include it into a namespace:

```ruby
require 'open_namespace'

module Project
  module Plugins
    include OpenNamespace
  end
end
```

Explicitly load constants via their file name:

```ruby
Project::Plugins.require_const :foo_bar
# => Project::Plugins::FooBar
```

Explicitly load constants containing uppercase acronyms:

```ruby
Project::Plugins.require_const :tcp_session
# => Project::Plugins::TCPSession
```

Explicitly load constants from nested directories:

```ruby
Project::Plugins.require_const 'templates/erb'
# => Project::Plugins::Templates::Erb
```

Implicitly load constants via `const_missing`:

```ruby
Project::Plugins::Other
# => Project::Plugins::Other
```

Loading constants from alternate namespace root directories:

```ruby
module Project
  module UI
    module CommandLine
      module Commands
        include OpenNamespace

        self.namespace_root = File.join(__dir__,'commands')
      end
    end
  end
end

Project::UI::CommandLine::Commands.require_const :help
# => Project::UI::CommandLine::Commands::Help
```

## Install

```shell
$ gem install open_namespace
```

## License

Copyright (c) 2010-2022 Hal Brodigan

See {file:LICENSE.txt} for license information.
