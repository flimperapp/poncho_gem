lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flimper_poncho/version'

Gem::Specification.new do |spec|
  spec.name          = 'flimper_poncho'
  spec.version       = FlimperPoncho::VERSION
  spec.authors       = ['Pablo Gonzaga']
  spec.email         = ['pgonzaga.uy@gmail.com']

  spec.summary       = ' Rest Client to use FlimperPoncho::API '
  spec.description   = ' This gem helps to abstract FlimperPoncho::API endpoints. '
  spec.homepage      = 'https://github.com/flimperapp/poncho_gem'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'byebug', '~> 11.0.1'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.66.0'
  spec.add_development_dependency 'webmock', '~> 3.5.1'

  spec.add_dependency 'active_interaction', '~> 3.7'
  spec.add_dependency 'faraday', '~> 0.15.4'
  spec.add_dependency 'jwt', '~> 2.1'
end
