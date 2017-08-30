#this class is called by the cli and handles outputs, menus
require "EbookDealInfo"

class Controller

  def call
    #functionality?
    self.welcome #call the intro message
  end

  def welcome
    #intro message
    puts "Welcome to the Ebook Daily Deal Info Getter"
    puts "Getting today's deals"
    puts "-----------------------------------------"
    #start scraping
    self.menu #main menu
  end

  def menu
    #the main menu
    puts "A list of today's deals:"
    #uses formatter to format the list
    #allows user to select an item for more information or exit the program
    #loop to handle odd inputs
  end

end
