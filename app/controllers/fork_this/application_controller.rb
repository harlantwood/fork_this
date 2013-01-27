module ForkThis
  class ApplicationController < ActionController::Base

    def populate_recent_changes
      @recent_changes = []  # Store.get_struct('updates', :collection => 'meta') || []
    end

  end
end
