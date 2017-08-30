#this class holds the data for each book
require "EbookDealInfo"

class Book
  attr_accessor :title, :author, :genre, :series, :goodreads_rating, :goodreads_rates, :blurb, :price
  @@all = [] #collection to push all new books into

  def initialize(arguments)
    @@all << self #push new books
    #do we want to set the attributes here or in create?
  end

  def self.create(item_from_deals_scrape_RENAME) #deals scrape will pass in hash with title, author, and price
    self.new #more efficient to pass in data here and do it in initialize or set below?
    #potential set attributes
  end

  def self.all #we'll use this to grab the collection, which the goodreads scraper will use
    @@all
  end

end
