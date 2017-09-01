#this class is called by the cli and handles outputs, menus
require_relative "EbookDealInfo"

class Controller
  attr_accessor :completed_books

  def call
    welcome #call the intro message
  end

  def welcome
    #intro message
    puts "Welcome to the Ebook Recent Deal Info Getter"
    puts "Getting the latest deals (this may take a while)"
    puts "----------------------------------------------------------------------------"
    DealScraper.new.scrape #call DealScraper, and through it instantiate books and call info_scraper on the books
    @completed_books = [] #we'll use this to avoid interacting with bad scrapes
    Book.all.each {|book| @completed_books << book if book.completable == true}
    list_books #main menu
  end

  def list_books
    #the main menu
    puts "A list of the latest deals:"
    puts "#{Book.all.select {|i| i.completable == false}.size} book(s) failed to load. Probably a spelling or selector error."
    @completed_books.each_with_index do |book, index|
      puts "#{index+1}. #{book.title} - #{book.author} - #{book.genre_one}"
    end

    interact
    exeunt
  end

  def interact
    input = nil
    while %w[e exit q quit n no].include?(input) == false
      puts "----------------------------------------------------------------------------\nEnter the number of the book you'd like more information about."
      puts "You can type list to list the books again or type quit to leave."
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= completed_books.size
        chosen_book = @completed_books[input.to_i-1]
        puts "----------------------------------------------------------------------------\n#{chosen_book.title}"
        puts "#{chosen_book.series}" if chosen_book.series.size > 0
        puts "By #{chosen_book.author}"
        if chosen_book.price.size > 0
          puts "Price: #{chosen_book.price}"
        else
          puts "Couldn't find a price"
        end
        if chosen_book.genre_two.include?(chosen_book.genre_one)
          puts "Shelved as #{chosen_book.genre_two}"
        elsif chosen_book.genre_one == "No genre listed"
          puts "This book doesn't have a genre listing"
        else
          puts "Shelved as #{chosen_book.genre_one} #{"and #{chosen_book.genre_two}" if chosen_book.genre_two.size > 0}"
        end
        puts "#{chosen_book.rates} people gave this book an average rating of #{chosen_book.rating}"
        puts "----------------------------------------------------------------------------\n#{chosen_book.wrap_blurb}" #line wrap our blurb
      elsif input == "list"
        list_books
      elsif %w[e exit q quit n no].include?(input) == false
        puts "Sorry, I couldn't understand that. Please enter a number, list, or quit."
      end
    end
  end

  def exeunt
    puts "----------------------------------------------------------------------------\nCheck back later for more ebook deals."
  end

end
