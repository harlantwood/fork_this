require 'haml'
require 'formtastic'
require 'polystore'
require 'rack-www'

module ForkThis
  class Engine < ::Rails::Engine

    isolate_namespace ForkThis

    initializer "force_www" do |app|
      app.middleware.use Rack::WWW, :predicate => lambda { |env|
        env['SERVER_NAME'] == ENV['BASE_DOMAIN']
      }
    end

    initializer "polystore" do |app|
      stores = ENV['POLYSTORES'].to_s.split(',').map(&:strip)
      raise "Please specify stores in POLYSTORES environment variable" if stores.size < 1
      config.storage = PolyStore[*stores]
    end

    initializer "domains" do |app|
      config.home_subdomain = "www"
      config.home_domain = "#{config.home_subdomain}.#{ENV['BASE_DOMAIN']}"
    end
    
  end
end
