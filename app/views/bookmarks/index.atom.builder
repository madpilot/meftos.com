atom_feed do |feed|
	feed.title("meftos.com bookmarks")
	feed.updated(@bookmarks.first.created_at)
	feed.root_url('http://' + request.host + '/')

	@bookmarks.each do |bookmark|
		feed.entry(bookmark.id, :url => (bookmark.url)) do |entry|
			entry.title(bookmark.title)
			entry.content(bookmark.description, :type => 'text')
		end
	end
end
