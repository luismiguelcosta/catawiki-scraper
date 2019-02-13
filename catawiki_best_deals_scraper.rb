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

# everything works until here, with the last puts I get an array
# with all the URLs I wanted
# - - - - - - - - - - - - -

links.each do |auction|
  html = open(auction)
  content = html.read
  parsed_content = Nokogiri::HTML(content)
  title = parsed_content.css('.lot_title').text
  puts "-> Auction title: #{title}"
  auction_url = auction
  puts "URL: #{auction_url}"
  estimate_value = parsed_content.css('.cw-currency-amount-eur').text.split(' ')
  puts "Expert's estimate: #{estimate_value[0]} - #{estimate_value[2]}"
  next_minimum_bid = parsed_content.css('.amount').text
  puts "Next minimum bid is: #{next_minimum_bid}"
  location = parsed_content.css('.bid_extra_costs').text.split(' ')
  puts "#{location[0]} #{location[1]}"
  puts " "
end

# now I have the title, url, expert's estimate value, next minimum bid
# and location for all those auctions
# - - - - - - - - - - - - -
