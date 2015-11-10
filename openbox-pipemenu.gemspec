# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openbox/pipemenu/version'

Gem::Specification.new do |spec|
  spec.name          = "openbox-pipemenu"
  spec.version       = Openbox::Pipemenu::VERSION
  spec.authors       = ["Ghardo"]
  spec.email         = ["ghardo@example.com"]

  spec.summary       = "Openbox pipemenu class"
  spec.description   = "A class to generate openbox pipemenus in ruby"
  
  spec.files         = [
	  "lib/openbox/pipemenu.rb",
	  "lib/openbox/pipemenu/version.rb"
  ]
   
  spec.require_paths = ["lib"]

  spec.add_development_dependency "nokogiri", "~> 1.6"
end
