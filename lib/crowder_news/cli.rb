##
# => Handles all interfacing with our user
##
class CLI
  # => Articles array accessor
  attr_accessor :articles

  # => Intiates the program, scrapes the website and welcomes the user
  def initiate
    Scraper.initiate_scrape
    puts "Welcome to Today on Crowder!"
    list_articles
  end

  ##
  # => Lists the articles according to the user's preferences
  ##
  def list_articles
    input = nil
    choices = 'Choose one: recent, featured, or both. To exit type "exit".'
    puts choices
    input = gets.strip.downcase
    puts ""
    if input == "recent"
      puts "Recent Articles: "
      @articles = Article.recents
      display_list(@articles)
      menu
    elsif input == "featured"
      puts "Featured Articles: "
      @articles = Article.featured
      display_list(@articles)
      menu
    elsif input == "both"
      puts "All articles: "
      @articles = Article.all
      display_list(@articles)
      menu
    elsif input == "exit"
      goodbye
    else
      list_articles
    end

  end

  ##
  # => Displays a list of articles for the user
  ##
  def display_list(articles)
    articles.each.with_index(1) do |article, index|
      puts "#{index}. #{article.title}"
      if(article.excerpt != "")
        puts "\t#{article.excerpt[0...98]}..."
      end
    end
    puts ""
  end

  ##
  # => Gives the user the options to view articles, switch lists, or exit the program
  ##
  def menu
    input = nil
    puts "Enter the number of the article you want to see, type list to list the articles again or type exit: "
    input = gets.strip.downcase
    if input.to_i > 0 && input.to_i < @articles.length + 1
      article = @articles[input.to_i - 1]
      display_article(article)
    elsif input == "list"
      list_articles
    elsif input == "exit"
      goodbye
    else
      puts "Please make a valid selection."
      menu
    end
  end

  ##
  # => Displays all of the article information for the user to read
  ##
  def display_article(article)
    input = nil
    puts "\n#{article.title}"
    puts "\nAuthor: #{article.author} on #{article.date}: "
    puts "\n\t#{article.body}"
    if article.youtube_links
      puts "\nYoutube Links:"
      article.youtube_links.each{ |link|
        puts link
      }
    end
    puts 'Press any key to find another article or "exit" to exit.'
    input = gets.strip.downcase
    if input == "exit"
      goodbye
    else
      list_articles
    end
  end

  ##
  # => Tells the user goodbye and exits program
  ##
  def goodbye
    puts "\nSee you next time!"
  end

end
