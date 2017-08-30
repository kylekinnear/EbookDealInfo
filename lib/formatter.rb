#this class formats the text for nice output
require "EbookDealInfo"

class Formatter

  def make_main_menu(Book.all) #takes the completed collection of book objects and iterates over them to generate the main menu
  end

  def make_more_details #should be called when the user wants more info on a specific item from main menu
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
  #return (lines.join "\n").gsub(/[.!?]\S/){|match| "#{match[0]}\n#{match[1]}"} - potentially nicer line breaks, works oddly, test?
end
