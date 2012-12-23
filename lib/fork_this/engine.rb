module ForkThis
  class Engine < ::Rails::Engine
    isolate_namespace ForkThis
  end
end
