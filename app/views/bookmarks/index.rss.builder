xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "meftos.com bookmarks"
    xml.link "http://meftos.com"
  
    @bookmarks.each do |bookmark|
      xml.item do
        xml.title bookmark.title
        xml.description bookmark.description
        xml.pubDate bookmark.created_at.to_s(:rfc822)
        xml.link bookmark.url
      end
    end
  end
end
