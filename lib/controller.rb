#this class is called by the cli and handles outputs, menus
require "EbookDealInfo"

class Controller

  def call
    #functionality?
    self.welcome #call the intro message
  end

  def welcome
    #intro message
    puts "Welcome to the Ebook Recent Deal Info Getter"
    puts "Getting the latest deals"
    puts "-----------------------------------------"
    DealScraper.new #call DealScraper, and through it instantiate books and call info_scraper on the books
    self.menu #main menu
  end

  def menu
    #the main menu
    puts "A list of the latest deals:"
    Book.all.each_with_index(1) do |book, index|
      puts "#{index}. #{book.title} - #{book.author} - #{book.genre}"
    #uses formatter to format the list
    #allows user to select an item for more information or exit the program
    #loop to handle odd inputs
  end

end
