require 'open-uri'
require 'nokogiri'
require 'json'

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

categories.each do |category_url|
  mother_url = "https://www.catawiki.com/c"
  child_url = category_url
  url = "#{mother_url}/#{child_url}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search(".c-card").each do |element|
    filtered_urls << element.attribute('href')
  end

  # html_doc.search(".be-lot__price").each do |bet|
  #   current_bet_value = bet.text
  #   # puts current_bet_value
  #   current_bet = current_bet_value.match(/([0-9]+,[0-9]{3})/)
  #   puts current_bet
  # end

  filtered_urls.each do |filtered_url|
    html_file = open(filtered_url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search(".cw-currency-amount-eur").each do |estimated_price|
      cost_interval = estimated_price.text
      value = cost_interval.match(/([0-9]+,[0-9]{3})/)
      puts value
    end
  end
end
