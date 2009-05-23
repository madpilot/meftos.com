namespace :meftos do
  desc "Import del.icio.us bookmarks from a local html page"
  task :import => :environment do
    html = ''
    File.open('/var/www/meftos.com/import.html', "r") do |f|
      while (line = f.gets)
        html << line
      end
    end
   
    Bookmark.delete_all
    doc = Nokogiri::HTML(html)
    doc.xpath("//html/body/dl/dt/a").each do |link|
      bookmark = Bookmark.new(:url => link['href'], :created_at => DateTime.parse(Time.at(link['add_date'].to_i).to_s), :tag_list => link['tags'], :title => link.content)
      bookmark.save!
    end
  end
end
