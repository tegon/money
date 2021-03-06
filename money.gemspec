require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'money'
  s.summary     = 'Currency conversion library'
  s.description = 'Convert currencies and perform arithmetic operations'
  s.authors     = ['Leonardo Tegon']
  s.email       = 'ltegon93@gmail.com'
  s.files       = [
    'lib/money.rb',
    'lib/version.rb'
  ]
  s.homepage    = 'https://github.com/tegon/money'
  s.license     = 'MIT'
  s.version     = MoneyVersion::VERSION
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency 'minitest', '5.10.1'
  s.add_development_dependency 'rake', '12.0.0'
end
