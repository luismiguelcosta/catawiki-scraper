require "open-uri"
require "nokogiri"

def fetch_auction_urls
  url = "https://www.catawiki.com/c/708-classic-cars-motorcycles-automobilia?927=62024&reserve_price=0"
  doc = Nokogiri::HTML(open(url).read)
  auctions = doc.search(".c-card")
  # puts auctions
  auctions.map do |auction|
    pages = doc.search(".a[href]")
    puts pages
  end
  # url = doc.at("a")["href"]
  # puts url
#   movies.take(5).map do |movie|
#     uri = URI.parse(movie.attributes["href"].value)
#     uri.scheme = "http"
#     uri.host = "www.imdb.com"
#     uri.query = nil
#     uri.to_s
#   end
end

# doc = Nokogiri::HTML('<div class="foo"></div>')
# doc.at('div')['class']

fetch_auction_urls

# def scrape_movie(url)
#   doc = Nokogiri::HTML(open(url, "Accept-Language" => "en").read)
#   m = doc.search("h1").text.match /(?<title>.*)[[:space:]]\((?<year>\d{4})\)/
#   title = m[:title]
#   year = m[:year].to_i

#   storyline = doc.search(".summary_text").text.strip
#   director = doc.search("[itemprop='director']").text.strip
#   cast = doc.search("[itemprop='actor']").take(3).map do |element|
#     element.text.strip
#   end

#   {
#     title: title,
#     cast: cast,
#     director: director,
#     storyline: storyline,
#     year: year
#   }
# end
