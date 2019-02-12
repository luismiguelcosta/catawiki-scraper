require "open-uri"
require "nokogiri"

# url = "https://www.catawiki.com/c/708-classic-cars-motorcycles-automobilia"
url = "https://www.catawiki.com/c/708-classic-cars-motorcycles-automobilia?927=62024&reserve_price=0"
html = open(url)
content = html.read
parsed_content = Nokogiri::HTML(content)
auctions = parsed_content.css(".be-lot__description")
# puts auctions.class.instance_methods
# puts auctions

links = auctions.css('div.be-lot__description p').map { |link| link['a'] }
puts links

# urls = []

# here I can explore all the interesting auctions from that url, and it works
# all_auctions = doc.xpath('//article[@class="be-lot u-word-break"]')
# puts all_auctions

# puts doc.css("href")

# div_map = div.map do |href|
#   puts href.class
# end

# div_each = []
# div.each do |auction|
#   div_each << auction
# end

# all_auctions = div_each[0].to_a
# puts all_auctions

# musicians_starting_with_a = musicians.select do |musician|
#   musician.start_with?("A")
# end

# doc.search('.href').each do |element|
#   puts element
# end

# puts doc

# doc.search('.be-lot u-word-break').each do |element|
#   puts element
# end
