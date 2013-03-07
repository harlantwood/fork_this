require File.expand_path("../lib/fork_this/subdomains", File.dirname(__FILE__))

ForkThis::Engine.routes.draw do
  root :to => 'crawl#new'
  resources :crawl, :only => %w[ new ]
  match 'crawl' => 'crawl#update', :as => :crawls

  if ENV['DOMAIN_CONNECTOR'].present?
    # eg http://en.wikipedia.org.via.forkthecommons.org/Unhosted
    match ':slug' => 'pages#via', :constraints => {
      :subdomain => /^(#{DOMAIN_SEGMENT_PATTERN}\.){2,}#{ENV['DOMAIN_CONNECTOR']}$/,
      :slug => %r{[^/<>+]+} }
  end

end
