require 'open-uri'
require 'nokogiri'

# url = "https://www.catawiki.com/c/708-classic-cars-motorcycles-automobilia"
url = 'https://www.catawiki.com/c/708-classic-cars-motorcycles-automobilia?927=62024&reserve_price=0'
html = open(url)
content = html.read
parsed_content = Nokogiri::HTML(content)
auctions = parsed_content.css('.be-lot__description')

anchors = auctions.css('a[href]')
links = anchors.map do |element|
  element['href']
end

# puts links

# everything works until here, with the last puts I get an array with all the URLs I wanted

links.each do |auction_url|
  html = open(auction_url)
  content = html.read
  parsed_content = Nokogiri::HTML(content)
  next_minimum_bid = parsed_content.css(".amount")
  puts next_minimum_bid
end

# now I have the next minimum bid for all those auctions
