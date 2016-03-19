# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'amazon_product/version'

Gem::Specification.new do |s|
  s.name        = 'amazon_product'
  s.version     = AmazonProduct::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Hakan Ensari']
  s.email       = ['code@papercavalier.com']
  s.homepage    = 'http://code.papercavalier.com/amazon_product/'
  s.summary     = %q{A Ruby wrapper to the Amazon Product Advertising API}
  s.description = %q{Amazon Product is a Ruby wrapper to the Amazon Product Advertising API.}

  s.add_runtime_dependency 'nokogiri', '>= 1.4'
  s.add_runtime_dependency 'eggnog'

  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  s.test_files    = Dir.glob('spec/**/*')
  s.require_paths = ['lib']
end
