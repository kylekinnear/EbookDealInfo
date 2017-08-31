#this class is called by the cli and handles outputs, menus
require_relative "EbookDealInfo"

class Controller

  def call
    #functionality?
    welcome #call the intro message
  end

  def welcome
    #intro message
    puts "Welcome to the Ebook Recent Deal Info Getter"
    puts "Getting the latest deals (this may take a while)"
    puts "-----------------------------------------"
    DealScraper.new.scrape #call DealScraper, and through it instantiate books and call info_scraper on the books
    list_books #main menu
  end

  def list_books
    #the main menu
    puts "A list of the latest deals:"
    puts "#{Book.all.select {|i| i.completable == false}.size} book(s) failed to load. Probably a spelling or selector error."
    Book.all.reject {|book| book.completable == false}.each_with_index do |book, index| #make this ignore books that are completable = false
      puts "#{index+1}. #{book.title} - #{book.author} - #{book.genre_one}"
    end

    interact
    exeunt
  end

  def interact
    input = nil
    while %w[e exit q quit n no].include?(input) == false
      puts "Enter the number of the book you'd like more information about."
      puts "You can type list to list the books again or type quit to leave."
      input = gets.strip.downcase

      if input.to_i > 0
        chosen_book = Book.all[input.to_i-1]
        puts "#{chosen_book.title}"
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
          puts "Shelved as #{chosen_book.genre_one} and #{chosen_book.genre_two}"
        end
        puts "#{chosen_book.rates} people gave this book an average rating of #{chosen_book.rating}"
        puts "#{chosen_book.blurb.wrap_blurb}" #line wrap our blurb
      elsif input == "list"
        list_books
      else
        puts "Sorry, I couldn't understand that. Please enter a number, list, or quit."
      end
    end
  end

  def exeunt
    puts "Check back later for more ebook deals."
  end


end
