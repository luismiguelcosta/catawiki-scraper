# require "yaml"
require_relative "scraper"

puts "Fetching URLs"
urls = fetch_auction_urls

movies = urls.map do |url|
  puts "Scraping #{url}"
  scrape_movie(url)
end

# puts "Writing movies.yml"
# File.open("movies.yml", "w") do |f|
#   f.write(movies.to_yaml)
# end

puts "Done."
