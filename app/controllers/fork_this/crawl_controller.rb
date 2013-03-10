require 'fork_this/crawl'

module ForkThis

  class CrawlController < ApplicationController
    def new
      @crawl = ForkThis::Crawl.new
    end

    def create
      redirect_to crawl_path(params[:crawl][:start_url], :crawl => params[:crawl])
    end

    def update
      p 111, params
      ForkThis::Crawl.new.next_page params[:crawl]
        # :start_url => params[:crawl][:start],
        # :depth => params[:crawl][:depth],
        # :remaining_pages => params[:crawl][:remaining_pages]

      # redirect_to :post => :create, {:crawl => params[:crawl]}
    end

  end
end

