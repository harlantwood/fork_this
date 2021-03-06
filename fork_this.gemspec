$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem"s version:
require "fork_this/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fork_this"
  s.version     = ForkThis::VERSION
  s.authors     = ["Harlan T Wood"]
  s.email       = ["code@harlantwood.net"]
  s.homepage    = "https://github.com/harlantwood/fork_this"
  s.summary     = "Fork arbitrary web pages into Github repositories"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency "rails", "3.2.11"
  s.add_dependency "nokogiri", "~> 1.5.2"
  s.add_dependency "pismo", "~> 0.7.2"
  s.add_dependency "rest-client", "~> 1.6.7"
  s.add_dependency "html_massage", "~> 0.2.1"
  s.add_dependency "haml", "~> 3.1.7"
  s.add_dependency "formtastic", "~> 2.2.1"
  s.add_dependency "superstring", "~> 0.0.1"
  s.add_dependency "faraday", "~> 0.8.4"
  s.add_dependency "redcarpet", "~> 2.2.2"
  s.add_dependency "dotenv", "~> 0.5.0"
  s.add_dependency "rack-www", "~> 1.5.0"
  s.add_dependency "mechanize", ">= 2.5.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "awesome_print"
end
