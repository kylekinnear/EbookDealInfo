#this is the goodreads scraper
require "EbookDealInfo"

class InfoScraper

  def info_scrape(book) #for each instance of book in the class collection, go get blurb, series, gr rating/rates and add them to that instance; also author to deal with last name only from scrape?
    search_string = "#{book.author} #{book.title}".gsub(/(\W)+/, "+") #turns the author + title into a usable goodreads search string
    search_page = Nokogiri::HTML(open("https://www.goodreads.com/search?q=#{search_string}&search_type=books")) #uses the search string to pull an item's goodreads page
    if search_page.css("table a").size != 0
      item_page = Nokogiri::HTML(open("https://goodreads.com/#{search_page.css("table a").attribute("href").value}").read)
    else #instead of a raising a nobook error that will break the looping, let's flag the book as incomplete and not display it at the end
      book.completable = false
    end
    book.author = item_page.css("div#bookAuthors.stacked span :not(.greyText) :not(.smallText)").text #gets the complete author name since reddit might not provide it
    #how do we handle no_series, and can we tidy the code?
    book.series = ((item_page.css("h1#bookTitle.bookTitle :first-child").text.strip).sub "(", "").sub ")", "" #provides series
    book.rating = item_page.css("span.average").text #average rating
    book.rates = item_page.css("span.votes.value-title").text.strip #number of ratings
    #blurb needs work
    book.blurb = item_page.xpath('//span[starts-with(@id, "freeText")]')[1].text#.gsub(/\s+/, " ") #grab the blurb
    book.wrap_blurb #line wrap for our blurb
    #we will scrape the top two genre entries, but when we want to check if one is a more specific form of the other
    genre_one = item_page.search("div.bigBoxContent div.elementList div.left")[0].text.split("\n").map {|i| i.strip}.map {|i| i if i.size > 0}.reject {|i| i == nil} # turn the first genre into a stripped array of actual content
    book.genre_one = ""
    genre_one.each {|i| book.genre_one << i}
    genre_two = item_page.search("div.bigBoxContent div.elementList div.left")[1].text.split("\n").map {|i| i.strip}.map {|i| i if i.size > 0}.reject {|i| i == nil}
    book.genre_two = ""
    genre_two.each {|i| book.genre_two << i}
  end

end
