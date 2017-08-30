#this class grabs the daily deals from reddit /r/ebookdeals
require "EbookDealInfo"

class DealScraper

  def scrape #this method scrapes the deals page, then for each item on that page, instantiates a new book with the relevant info; are we passing a hash or attributes?
    deals = Nokogiri::HTML(open("https://www.reddit.com/r/ebookdeals/new/"))
    deals.search("div.link").each do |post|
      if post.search("p.title").text.size > 0
        if post.search("p.title").text.include?(";") #for posts formatted "#~Author~; ~Title; ~Price~"
          author = post.seach("p.title").text.split(";")[0].strip
          title = post.seach("p.title").text.split(";")[1].strip
          price = post.seach("p.title").text.split(";")[2].strip
          Book.create(author, title, price)
        else #for posts formatted "~Title~ by ~author~ (~Price~)"
          author = post.search("p.title").text.split("by").first.strip
          title = post.search("p.title").text.split("by")[1].slice(/\A[^(]+/).strip
          price = post.search("p.title").text.slice(/[$]\d+[.]\d+/).strip
          Book.create(author, title, price)
        end
      end
  end

end
