require File.expand_path("../lib/fork_this/subdomains", File.dirname(__FILE__))

ForkThis::Engine.routes.draw do
  root :to => 'forked_pages#new'
  resources :forked_pages, :only => %w[ new create ]
  if ENV['DOMAIN_CONNECTOR'].present?
    # eg http://p2pfoundation.net.via.forkthecommons.org/Unhosted
    match ':slug' => 'pages#via', :constraints => { :subdomain => /^(#{DOMAIN_SEGMENT_PATTERN}\.){2,}#{ENV['DOMAIN_CONNECTOR']}$/, :slug => %r{[^/<>+]+} }
  end
end
