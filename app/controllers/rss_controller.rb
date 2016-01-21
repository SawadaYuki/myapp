class RssController < ApplicationController
	url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/sf=143462/limit=10/xml"
	url = ARGV.shift if ARGV.length &gt; 0
	page = open(url) 
	@rss = SimpleRSS.parse(page)
end
