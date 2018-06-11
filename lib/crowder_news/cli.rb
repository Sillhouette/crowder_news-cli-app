##
# => Handles all interfacing with our user
##
class CrowderNews::CLI
  # => Articles array accessor
  attr_accessor :articles

  # => Intiates the program, scrapes the website and welcomes the user
  def call
    CrowderNews::Scraper.initiate_scrape
    puts "Welcome to Today on Crowder!"
    list_articles
  end

  ##
  # => Lists the articles according to the user's preferences
  ##
  def list_articles
    input = nil
    choices = "Choose one: recent, featured, or both"
    puts choices
    input = gets.strip.downcase
    puts ""
    if input == "recent"
      puts "Recent Articles: "
      @articles = CrowderNews::Article.recents
    elsif input == "featured"
      puts "Featured Articles: "
      @articles = CrowderNews::Article.featured
    elsif input == "both"
      puts "All articles: "
      @articles = CrowderNews::Article.all
    else
      puts choices
    end
    if @articles
      display_list(@articles)
      menu
    end
  end

  ##
  # => Displays a list of articles for the user
  ##
  def display_list(articles)
    articles.each.with_index(1) do |article, index|
      puts "#{index}. #{article.title}"
      if(article.excerpt != "")
        puts "    #{article.excerpt[0...103]}..."
      end
    end
  end

  ##
  # => Gives the user the options to view articles, switch lists, or exit the program
  ##
  def menu
    input = nil
    until input == 'exit'
      puts "Enter the number of the article you want to see, type list to list the articles again or type exit: "
      input = gets.strip.downcase
      if input.to_i > 0
        article = @articles[input.to_i - 1]
        display_article(article)
      elsif input == "list"
        list_articles
      end
    end
    goodbye
  end

  ##
  # => Displays all of the article information for the user to read
  ##
  def display_article(article)
    input = nil
    puts ""
    puts "#{article.title}"
    puts ""
    puts "Author: #{article.author} on #{article.date}: "
    puts ""
    puts "    #{article.body}"
    if article.youtube_links
      puts ""
      puts "Youtube Links:"
      article.youtube_links.each{ |link|
        puts link
      }
    end
    puts 'Press any key to choose a new article.'
    input = gets.strip.downcase
    list_articles
  end

  ##
  # => Tells the user goodbye and exits program
  ##
  def goodbye
    puts "See you next time!"
  end

end
