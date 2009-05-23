require 'nokogiri'
require 'open-uri'

class Bookmark < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 100

  acts_as_taggable_on :tags
  
  validates_format_of :url, :with => /.+:\/\/.+/
  validates_presence_of :title

  def normalize
    self.url = 'http://' + self.url unless self.url =~ /.+:\/\/.+/
  end

  def self.normalize(url)
    url = "http://#{url}" unless url =~ /.+:\/\/.+/
    url
  end

  def fetch_metadata
    normalize
    begin
      doc = Nokogiri::HTML(open(url))
    
      doc.xpath('//html/head/title').each do |t|
        self.title = t.content
      end

      doc.xpath('//html/head/meta').each do |m|
        self.description = m['content'] if (m['name'] && m['name'].downcase == "description")
        self.tag_list = m['content'] if (m['name'] && m['name'].downcase == "keywords")
      end
    rescue; end
  end
end
