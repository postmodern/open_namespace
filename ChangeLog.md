### 0.3.1 / 2011-03-08

* Fixed a typo in {OpenNamespace::ClassMethods#require_file}.

### 0.3.0 / 2010-04-28

* Added {OpenNamespace.constant_path}.
* Added {OpenNamespace::ClassMethods#require_file}.
* Added {OpenNamespace::ClassMethods#const_search}.
* Improved searching for constants with oddly capitalized names, such as
  `SQL` or `RemoteTCP`.
* Ensure that {OpenNamespace::ClassMethods#const_missing} only returns the
  constant with the requested name.
* Removed `OpenNamespace::ClassMethods#namespace`.
* Removed `OpenNamespace::ClassMethods#namespace=`.
* Removed the dependency on extlib.

### 0.2.0 / 2010-04-13

* Renamed the open-namespace gem to open_namespace, for naming consistency.

### 0.1.0 / 2010-02-11

* Require extlib >= 0.9.14.
* Provides implicit loading of constants via `const_missing`.
* Provides explicit loading of constants via `require_const`.

