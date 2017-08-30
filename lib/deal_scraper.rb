#this class grabs the daily deals from reddit /r/ebookdeals
require "EbookDealInfo"

class DealScraper

  def scrape #this method scrapes the deals page, then for each item on that page, instantiates a new book with the relevant info; are we passing a hash or attributes?
    deals = Nokogiri::HTML(open("https://www.reddit.com/r/ebookdeals/new/"))
  end

end


"div#siteTable .sitetable linklisting" #wrapper
"div .class id-t3 (even || odd) link"#each item on page
"p.title" within "div.top-matter" within "div.entry unvoted" #individual item line
        #breaks down to
          #~Title~ by ~author~ (~Price~)
          #or
          #~Author~; ~Title; ~Price~
