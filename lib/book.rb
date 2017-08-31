#this class holds the data for each book
require_relative "EbookDealInfo"

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

  def wrap_blurb(width=78) #code from other projects to make blurbs line wrap; handle unicode replacement elsewhere
  lines = []
  line = ""
  @blurb.split(/\s+/).each do |word|
    if line.size + word.size >= width
      lines << line
      line = word
    elsif line.empty?
      line = word
    else
      line << " " << word
    end
  end
  lines << line if line
  end

end
