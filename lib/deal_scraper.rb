#this class grabs the daily deals from amazon

class DealScraper

  def scrape #this method scrapes the deals page, then for each item on that page, instantiates a new book with the relevant info; are we passing a hash or attributes?
    deals = Nokogiri::HTML(open("https://www.amazon.com/s/ref=s9_acsd_hps_ft_clnk_r?node=6165851011"))
  end

end
