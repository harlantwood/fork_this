module ForkThis
  class ApplicationController < ActionController::Base

    def populate_recent_changes
      @recent_changes = Engine.config.storage.get_struct('updates.json', :collection => 'meta') || []
    end

  end
end
