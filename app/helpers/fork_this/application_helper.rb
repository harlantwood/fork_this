module ForkThis
  module ApplicationHelper                                         
    def home_domain
      Engine.config.home_domain
    end    
  end
end
