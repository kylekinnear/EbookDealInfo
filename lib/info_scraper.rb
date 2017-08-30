#this is the goodreads scraper
require "EbookDealInfo"

class InfoScraper

  def info_scrape(book) #for each instance of book in the class collection, go get blurb, series, gr rating/rates and add them to that instance; also author to deal with last name only from scrape?
    search_string = "#{testbook.author} #{testbook.title}".gsub(/(\W)+/, "+") #turns the author + title into a usable goodreads search string
    search_page = Nokogiri::HTML(open("https://www.goodreads.com/search?q=#{search_string}&search_type=books")) #uses the search string to pull an item's goodreads page
    if search_page.css("table a").size != 0
      item_page = Nokogiri::HTML(open("https://goodreads.com/#{search_page.css("table a").attribute("href").value}").read)
    else #instead of a raising a nobook error that will break the looping, let's flag the book as incomplete and not display it at the end
      book.completable = false
    end
    author = item_page.css("div#bookAuthors.stacked span :not(.greyText) :not(.smallText)").text #gets the complete author name since reddit might not provide it
    series = ((item_page.css("h1#bookTitle.bookTitle :first-child").text.strip).sub "(", "").sub ")", "" #provides series
  end


end


#other project code
#def scrape
#  puts "Enter your search term (usually combination of author and title)"
#  input = gets.strip #gets input line
#  if input.size > 0 #checks valid input
#    if input.upcase == "quit".upcase
#      return
#    end
#    puts "Checking now!"
#    input.gsub!(/(\W)+/, "+") #formats input as valid search string
#    search_page = Nokogiri::HTML(open("https://www.goodreads.com/search?q=#{input}&search_type=books")) #interpolates input to search url and pulls page with nokogiri
#    if search_page.css("table a").size != 0
#      item_page = Nokogiri::HTML(open("https://goodreads.com/#{search_page.css("table a").attribute("href").value}").read)
#    else
#      raise NoBook
#    end
#    @author = item_page.css("div#bookAuthors.stacked span :not(.greyText) :not(.smallText)").text
#    @title = item_page.css("h1#bookTitle.bookTitle").text.reverse.strip.reverse.lines.first.chomp #provides title
#    @series = ((item_page.css("h1#bookTitle.bookTitle :first-child").text.strip).sub "(", "").sub ")", "" #provides series
#    @release_date = item_page.css("div#details .row").text.split(/\n+/)[2].sub /\A\s+/, "" #provides the release date
#    @average = item_page.css("span.average").text
#    @ratings = item_page.css("span.votes.value-title").text.strip
#    @blurb = item_page.xpath('//span[starts-with(@id, "freeText")]')[1].text.gsub(/\s+/, " ")
#  end
#end
