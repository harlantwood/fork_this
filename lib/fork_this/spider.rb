require 'mechanize'
# require 'logger'
require 'polystore/all'
# require 'superstring'
require 'fileutils'
require 'html_massage'

module ForkThis

  class Spider

    include FileUtils

    def crawl(options)
      url = options[:url] || raise
      agent = Mechanize.new
      log_dir = "tmp/logs"
      mkdir_p log_dir
      agent.log = Logger.new File.join(log_dir, "mechanize.log")
      agent.user_agent_alias = 'Mac Safari'
      agent.max_history = nil # unlimited history

      page = agent.get(url)
      save page
      links = page.links
      max_pages = 3
      pages = 1

      while pages < max_pages && link = links.pop
        next unless link.uri
        host = link.uri.host
        next unless host.nil? || host == agent.history.first.uri.host  # only crawl pages on original site
        next if agent.visited? link.href

        begin
          page = link.click
          save page
          pages += 1
          next unless Mechanize::Page === page
          links.push(*page.links)
        rescue Mechanize::ResponseCodeError => err
          puts err
        end
      end

    end

    def save(page)
      puts "saving #{page.uri}"
      content = HtmlMassage.html(page.body)
      storage.put_text "#{page.uri.path.slug}.html", content, :collection => page.uri.host
      sleep 1+rand   # crawl considerately
    end

    def storage
      unless @storage
        @storage ||= PolyStore::Storage.new
        @storage << PolyStore::FileStore.new #:dir => File.join(Dir.pwd, 'tmp')
        @storage << PolyStore::GithubStore.new
      end
      @storage
    end

  end
end

