require 'rubygems'
require 'rake'
require './lib/open_namespace/version.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'open-namespace'
    gem.version = OpenNamespace::VERSION
    gem.summary = %Q{Allows namespaces to load constants on-demand}
    gem.description = %Q{OpenNamespace allows namespaces to require and find class and modules from other gems.}
    gem.email = 'postmodern.mod3@gmail.com'
    gem.homepage = 'http://github.com/postmodern/open-namespace'
    gem.authors = ['Postmodern']
    gem.add_dependency 'extlib', '>= 0.9.14'
    gem.add_development_dependency 'rspec', '>= 1.2.9'
    gem.add_development_dependency 'yard', '>= 0.4.0'

    gem.has_rdoc = 'yard'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :spec => :check_dependencies
task :default => :spec

begin
  require 'yard'

  YARD::Rake::YardocTask.new
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yard, you must: gem install yard"
  end
end
