#this class grabs the daily deals from amazon
require "EbookDealInfo"

class DealScraper

  def scrape #this method scrapes the deals page, then for each item on that page, instantiates a new book with the relevant info; are we passing a hash or attributes?
    deals = Nokogiri::HTML(open("https://www.reddit.com/r/ebookdeals/new/"))
  end

end
