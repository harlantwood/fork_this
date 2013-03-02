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
      config.storage = PolyStore.create(ENV['POLYSTORES'] || 'file')
    end

    initializer "domains" do |app|
      config.home_subdomain = "www"
      config.home_domain = "#{config.home_subdomain}.#{ENV['BASE_DOMAIN']}"
    end
    
  end
end
