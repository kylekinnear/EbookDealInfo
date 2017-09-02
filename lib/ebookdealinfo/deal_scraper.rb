#this class grabs the daily deals from reddit /r/ebookdeals
#require_relative "EbookDealInfo"

class DealScraper

  def scrape #this method scrapes the deals page, then for each item on that page, instantiates a new book with the relevant info; are we passing a hash or attributes?
    deals = Nokogiri::HTML(open("https://www.reddit.com/r/ebookdeals/new/",'User-Agent' => 'Chrome'))

    deals.search("div.link").each_with_index do |post,index|
      if post.search("p.title").text.size > 0
        if post.search("p.title").text.include?(";") #for posts formatted "#~Author~; ~Title; ~Price~"
          author = post.search("p.title").text.split(";")[0].strip
          title = post.search("p.title").text.split(";")[1].strip
          post.search("p.title").text.split(";")[2] != nil ? price = post.search("p.title").text.split(";")[2].strip : price = ""
          Book.create(author, title, price)
          puts "Loaded book ##{index+1} of #{deals.search("div.link").size}"
        else #for posts formatted "~Title~ by ~author~ (~Price~)"
          if post.search("p.title").text.slice(/[,.-[ ]]([Bb]y)/) != nil #ignore wacky formatted posts
            author = post.search("p.title").text.split("by")[1].strip.slice(/\A[^(,$\/]+/).split(". Kindle")[0].split("-- Kindle")[0].strip
            title = post.search("p.title").text.split("by").first.gsub(/[(].+[)]/,"").gsub(/\W+\z/, "").strip
            post.search("p.title").text.slice(/[$]\d+[.]\d+/) != nil ? price = post.search("p.title").text.slice(/[$]\d+[.]\d+/).strip : price = ""
            Book.create(author, title, price)
            puts "Loaded book ##{index+1} of #{deals.search("div.link").size}"
          else
            puts "Unable to load book ##{index+1} of #{deals.search("div.link").size}. Probably a bad post name."
            Book.create("","","",0)
          end
        end
      end
    end
  end

end
