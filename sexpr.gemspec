$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require "sexpr/version"
$version = Sexpr::Version.to_s
Gem::Specification.new do |s|
  s.name = "sexpr"
  s.version = $version
  s.summary = "A compilation framework around s-expressions"
  s.description = "Sexpr helps manipulating s-expressions in ruby."
  s.homepage = "https://github.com/blambeau/sexp"
  s.authors = ["Bernard Lambeau"]
  s.email  = ["blambeau@gmail.com"]
  s.require_paths = ["lib"]
  s.files = Dir['LICENSE.md','CHANGELOG.md','Gemfile','Rakefile', '{bin,lib,spec,tasks}/**/*', 'README*'] & `git ls-files -z`.split("\0")
  s.bindir = "bin"
  s.executables = (Dir["bin/*"]).collect{|f| File.basename(f)}

  s.add_development_dependency("path", "~> 1.3")
  s.add_development_dependency("citrus", "~> 3.0")
  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("rspec", "~> 3.10")
end
