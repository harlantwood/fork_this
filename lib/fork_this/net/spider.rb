require 'mechanize'
# require 'logger'
require 'polystore/all'
# require 'superstring'
require 'fileutils'
require 'html_massage'
require 'date'

module ForkThis
  module Net

    class Spider

      include FileUtils

      def crawl(options)
        url = options[:url] || raise('please pass in options[:url]')
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

          # :start_url => params[:crawl][:start],
          # :depth => params[:crawl][:depth],
          # :remaining_pages => params[:crawl][:remaining_pages]

      def next_page(options)
        start_url = options[:start_url] || raise('please pass in options[:start_url]')
        agent = Mechanize.new
        # log_dir = "tmp/logs"
        # mkdir_p log_dir
        # agent.log = Logger.new File.join(log_dir, "mechanize.log")
        agent.user_agent_alias = 'Mac Safari'
        agent.max_history = nil # unlimited history

        all_links         = storage.get_struct "meta/links.json",         :collection => start_url.host_without_www
        all_visited_links = storage.get_struct "meta/visited_links.json", :collection => start_url.host_without_www

        links = all_links[start_url].sort{ |a,b| a.value['depth'] <=> b.value['depth'] }
        visited_links = all_visited_links.keys
        next_link = links.find{ |link| !visited_links.contains?(link.key) }
        url = next_link.key
        depth = next_link.value['depth']

        page = agent.get(url)
        save page
        new_links = page.links

        new_links.each do |new_link|
          links[new_link] ||= {'depth' => depth + 1}
        end

        all_visited_links.merge url => { 'visited' => DateTime.now.utc.iso8601 }

        storage.put_struct "meta/links.json",         all_links,         :collection => start_url.host_without_www
        storage.put_struct "meta/visited_links.json", all_visited_links, :collection => start_url.host_without_www

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
end

