#this class holds the data for each book
require "EbookDealInfo"

class Book
  attr_accessor :author, :title, :price, :genre_one, :genre_two, :series, :rating, :rates, :blurb, :completable
  @@all = [] #collection to push all new books into

  def initialize(author, title, price)
    @@all << self #push new books
    @author = author
    @title = title
    @price = price
    @completable = true
    InfoScraper.new.info_scrape(self)
  end

  def self.create(author, title, price) #deals scrape will pass in hash with title, author, and price
    self.new(author, title, price)
  end

  def self.all #we'll use this to grab the collection, which the goodreads scraper will use
    @@all
  end

end
