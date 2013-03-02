require 'fork_this/spider'
require 'thor'
require 'mechanize'
require 'logger'
require 'polystore/all'
require 'superstring'
require 'fileutils'
require 'html_massage'

module ForkThis

  class CLI < Thor

    include FileUtils

    desc :crawl, 'Download HTML from given URL and store'
    def crawl(url)
      ForkThis::Spider.new.crawl :url => url
    end

  end

end

