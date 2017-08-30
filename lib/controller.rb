#this class is called by the cli and handles outputs, menus
require "EbookDealInfo"

class Controller

  def call
    #functionality?
    welcome #call the intro message
  end

  def welcome
    #intro message
    puts "Welcome to the Ebook Recent Deal Info Getter"
    puts "Getting the latest deals"
    puts "-----------------------------------------"
    DealScraper.new #call DealScraper, and through it instantiate books and call info_scraper on the books
    list_books #main menu
  end

  def list_books
    #the main menu
    puts "A list of the latest deals:"
    Book.all.each_with_index(1) do |book, index| #make this ignore books that are completable = false
      puts "#{index}. #{book.title} - #{book.author} - #{book.genre}"
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
        if chosen_book.price > 0
          puts "#{chosen_book.price}"
        else
          puts "Couldn't find a price"
        end
        if chosen_book.genre_two.include?(chosen_book.genre_one)
          puts "Shelved as #{chosen_book.genre_two}"
        else
          puts "Shelved as #{chosen_book.genre_one} and #{chosen_book.genre_two}"
        end
        puts "#{chosen_book.rates} people gave this book an average rating of #{chosen_book_rating}"
        puts "#{chosen_book.blurb}"
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
