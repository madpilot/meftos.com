class Url < ActiveRecord::Base
  validates_format_of :url, :with => /.+:\/\/.+/

  def normalize
    Url.normalize(self.url)
  end

  def self.normalize(url)
    url = "http://#{url}" unless url =~ /.+:\/\/.+/
    url
  end

  def permalink
    id.to_s(36) 
  end
end
