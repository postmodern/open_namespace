# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{open_namespace}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Postmodern"]
  s.date = %q{2010-04-13}
  s.description = %q{OpenNamespace allows namespaces to require and find classes and modules from other RubyGems.}
  s.email = %q{postmodern.mod3@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog.md",
     "LICENSE.txt",
     "README.md"
  ]
  s.files = [
    ".gitignore",
     ".specopts",
     ".yardopts",
     "ChangeLog.md",
     "LICENSE.txt",
     "README.md",
     "Rakefile",
     "lib/open_namespace.rb",
     "lib/open_namespace/class_methods.rb",
     "lib/open_namespace/open_namespace.rb",
     "lib/open_namespace/version.rb",
     "spec/classes/custom/bad_constant.rb",
     "spec/classes/custom/constant_one.rb",
     "spec/classes/custom/constant_two.rb",
     "spec/classes/custom/sub/constant_four.rb",
     "spec/classes/custom_namespace.rb",
     "spec/classes/simple_namespace.rb",
     "spec/classes/simple_namespace/bad_constant.rb",
     "spec/classes/simple_namespace/constant_one.rb",
     "spec/classes/simple_namespace/constant_two.rb",
     "spec/classes/simple_namespace/sub/constant_four.rb",
     "spec/open_namespace_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.has_rdoc = %q{yard}
  s.homepage = %q{http://github.com/postmodern/open-namespace}
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Allows namespaces to load constants on-demand}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/open_namespace_spec.rb",
     "spec/classes/custom_namespace.rb",
     "spec/classes/custom/constant_two.rb",
     "spec/classes/custom/constant_one.rb",
     "spec/classes/custom/bad_constant.rb",
     "spec/classes/custom/sub/constant_four.rb",
     "spec/classes/simple_namespace.rb",
     "spec/classes/simple_namespace/constant_two.rb",
     "spec/classes/simple_namespace/constant_one.rb",
     "spec/classes/simple_namespace/bad_constant.rb",
     "spec/classes/simple_namespace/sub/constant_four.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<extlib>, [">= 0.9.14"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0.5.3"])
    else
      s.add_dependency(%q<extlib>, [">= 0.9.14"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0.5.3"])
    end
  else
    s.add_dependency(%q<extlib>, [">= 0.9.14"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0.5.3"])
  end
end
