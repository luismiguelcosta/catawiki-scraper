require 'open-uri'
require 'nokogiri'
require 'json'
require 'date'

@dtoday = Date.today.strftime("%Y%m%d")
puts @dtoday
puts @dtoday.class

@dtomorrow = (@dtoday.to_i + 1).to_s
puts @dtomorrow
puts @dtomorrow.class

@x = 0

categories = [
  # "1-antiques-curio?927=62024&reserve_price=0",
  "708-classic-cars-motorcycles-automobilia?927=62024&reserve_price=0",
  # "23-applied-art-design?927=62024&reserve_price=0",
  # "863-archaeology-natural-history?927=62024&reserve_price=0",
  # "85-art?927=62024&reserve_price=0",
  # "925-asian-art-ethnography?927=62024&reserve_price=0",
  # "139-books-comics?927=62024&reserve_price=0",
  # "165-coins-bullion-stamps?927=62024&reserve_price=0",
  # "725-computers-games-cameras?927=62024&reserve_price=0",
  # "714-diamonds-gemstones?927=62024&reserve_price=0",
  # "721-fashion?927=62024&reserve_price=0",
  # "299-jewellery-watches?927=62024&reserve_price=0",
  # "1099-militaria-weaponry?927=62024&reserve_price=0",
  # "347-music?927=62024&reserve_price=0",
  # "1097-sports?927=62024&reserve_price=0",
  # "363-toys-models?927=62024&reserve_price=0",
  # "720-wine-whisky?927=62024&reserve_price=0"
]

filtered_urls = []

puts "The following auctions:"
puts " - have no reserve price"
puts " - will end in less than one day"
puts " - have an estimated price from a Catawiki specialist"
puts "   |    |    |    |    | "
puts "   V    V    V    V    V "

categories.each do |category_url|
  mother_url = "https://www.catawiki.com/c"
  child_url = category_url
  url = "#{mother_url}/#{child_url}&bidding_end_days=#{@dtoday},#{@dtomorrow}"
  html_search_file = open(url).read
  html_search_doc = Nokogiri::HTML(html_search_file)

  html_search_doc.search(".c-card").each do |lot|
    filtered_urls << lot.attribute("href").to_s
  end

  puts filtered_urls

  html_search_doc.search(".c-card__title be-lot__title") do |auction|
    @title = auction.text.to_s
  end

  puts @title
end

filtered_urls.each do |filtered_url|
  html_auction_file = open(filtered_url).read
  html_auction_doc = Nokogiri::HTML(html_auction_file)

  html_auction_doc.search(".cw-currency-amount-eur").each do |estimated_price|
    cost_interval = estimated_price.text
    @value = cost_interval.match(/([0-9]+,[0-9]{3})|([0-9]{3})/)
  end

  html_auction_doc.search(".amount").each do |bid|
    current_bid_value = bid.text
    @current_bid = current_bid_value.match(/([0-9]+,[0-9]{3})|([0-9]{3})/)
  end

  # html_auction_doc.search(".lot_title") do |object|
  #   @title = object.attribute("title")
  # end

  html_auction_doc.search(".counter cw-tab-fig hasCountdown").each do |time|
    @end_time = time.text.to_s
    @remaining_time = @end_time.match(/(\S+)(?=[h])/)
  end

  if html_auction_doc.at_css(".cw-currency-amount-eur")
    puts "#{@x += 1} title: #{@title}"
    puts " - value: #{@value} | next minimum bid: #{@current_bid}"
    puts "   > ends in #{@remaining_time}"
    puts "#{@end_time}"
    puts "- - - - - -"
  end
end
