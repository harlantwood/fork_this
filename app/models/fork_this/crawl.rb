module ForkThis
  class Crawl < BaseModel

    attr_accessor :start_url
    validates :start_url, :format => { :with => %r{
          \A
          https?://
          #{DOMAIN_SEGMENT_PATTERN}
          ((\.#{DOMAIN_SEGMENT_PATTERN})+)
          }x, :message => "this doesn't look like a web page address" }

    def initialize(attributes = {})
      if attributes[:start_url].present? && attributes[:start_url] !~ %r{^https?://}
        attributes[:start_url] = "http://#{attributes[:start_url]}"
      end

      super attributes
    end

  end
end

