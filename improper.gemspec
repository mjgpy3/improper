Gem::Specification.new do |s|
  s.name = 'improper'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Michael "Gilli" Gilliland']
  s.homepage = 'https://github.com/mjgpy3/improper'
  s.date = '2014-07-14'
  s.summary = 'Property based value generators for Ruby!'
  s.description = 'Your wildest dreams have come true! Property based test generators in Ruby!'
  s.files = ['lib/improper.rb',
             'spec/lib/improper_spec.rb',
             'README.md']
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
