#this is the goodreads scraper
#require_relative "EbookDealInfo"

class InfoScraper

  def info_scrape(book) #for each instance of book in the class collection, go get blurb, series, gr rating/rates and add them to that instance; also author to deal with last name only from scrape?
    search_string = "#{book.title} #{book.author.gsub(".", ". ").gsub(/[^\w\s]/,"")}".gsub(/(\A|\s)\S\s/," ").gsub(/[^a-zA-Z0-9']+/, "+") #turns the author + title into a usable goodreads search string
          #should remove anything joining multiple authors ("&", ",") that would break the search
    search_page = Nokogiri::HTML(open("https://www.goodreads.com/search?q=#{search_string}&search_type=books",'User-Agent' => 'Ruby')) #uses the search string to pull an item's goodreads page
    if search_page.css("table a").size != 0
      determinant = search_page.css("span.minirating").map.with_index {|i,index| [index, i.text.strip.slice(/\s(\d|,)+/).strip.gsub(",","").to_i]}.sort! {|x,y| x[1].to_i <=> y[1].to_i}.last #the search result with the most rates (and presumably most legitimate) is an array [result_index, #rates]
      item_page = Nokogiri::HTML(open("https://goodreads.com/#{search_page.css("table a.bookTitle")[determinant[0]].attribute("href").value}",'User-Agent' => 'Ruby').read)
      book.author = item_page.search("div#bookAuthors.stacked span :not(.greyText) :not(.smallText)").text #gets the complete author name since reddit might not provide it
      book.title = item_page.search("h1#bookTitle.bookTitle").text.slice(/^(\n).+(\S\n)/).strip #goodreads provides better titles
      book.series = item_page.search("h1#bookTitle.bookTitle :first-child").text.strip.gsub(/[()]/, "") #provides series
      book.rating = item_page.search("span.average").text #average rating
      book.rates = item_page.search("span.votes.value-title").text.strip #number of ratings
      #blurb needs work
      book.blurb = item_page.xpath('//span[starts-with(@id, "freeText")]')[1].text#grab the blurb
      #we will scrape the top two genre entries, but when we want to check if one is a more specific form of the other
      if item_page.search("div.bigBoxContent div.elementList div.left").empty?
        book.genre_one = "No genre listed"
        book.genre_two = ""
      else
        genre_one = item_page.search("div.bigBoxContent div.elementList div.left")[0].text.split("\n").map {|i| i.strip if i.strip.size > 0}.reject {|i| i==nil} # turn the first genre into a stripped array of actual content
        book.genre_one = ""
        genre_one.each {|i| book.genre_one << "#{i} "}
        if item_page.search("div.bigBoxContent div.elementList div.left")[1] != nil
          genre_two = item_page.search("div.bigBoxContent div.elementList div.left")[1].text.split("\n").map {|i| i.strip if i.strip.size > 0}.reject {|i| i==nil}
          book.genre_two = ""
          genre_two.each {|i| book.genre_two << "#{i} "}
        else
          book.genre_two = ""
        end
      end
    else #instead of a raising a nobook error that will break the looping, let's flag the book as incomplete and not display it at the end
      book.completable = false
    end
  end

end
