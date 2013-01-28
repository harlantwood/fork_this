require 'haml'
require 'formtastic'

module ForkThis
  class Engine < ::Rails::Engine
    isolate_namespace ForkThis
    initializer "polystore" do |app|
      stores = ENV['POLYSTORES'].to_s.split(',').compact.map(&:strip)
      raise "Please specify stores in POLY_STORES environment variable" if stores.size < 1
      config.storage = PolyStore[*stores]
    end
  end
end
