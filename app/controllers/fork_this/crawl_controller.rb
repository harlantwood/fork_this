require 'fork_this/spider'

module ForkThis

  class CrawlController < ApplicationController
    def new
      @crawl = Crawl.new #params[:crawl]
    end

    def update
      ForkThis::Crawl.next_page params[:crawl]
        # :start_url => params[:crawl][:start],
        # :depth => params[:crawl][:depth],
        # :remaining_pages => params[:crawl][:remaining_pages]

      # redirect_to :post => :create, {:crawl => params[:crawl]}
    end

  end
end

