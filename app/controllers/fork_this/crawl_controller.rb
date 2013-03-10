require 'fork_this/net/crawl'

module ForkThis

  class CrawlController < ApplicationController
    def new
      @crawl = ForkThis::Net::Crawl.new
    end

    def update
      p 111, params
      ForkThis::Net::Crawl.new.next_page params[:net_crawl]
        # :start_url => params[:crawl][:start],
        # :depth => params[:crawl][:depth],
        # :remaining_pages => params[:crawl][:remaining_pages]

      # redirect_to :post => :create, {:crawl => params[:crawl]}
    end

  end
end

