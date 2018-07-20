##
# => Handles all interfacing with our user
##
class CLI
  # => Articles array accessor
  attr_accessor :articles

  ##
  # => Tells the user goodbye and exits program
  ##
  GOODBYE = "\nSee you next time!"

  # => Intiates the program, scrapes the website and welcomes the user
  def initiate
    Scraper.initiate_scrape
    puts "\n\nWelcome to Today on Crowder! To exit type 'exit'."
    list_articles
  end

  ##
  # => Lists the articles according to the user's preferences
  ##
  def list_articles
    input = nil
    puts "\nWhat kind of article would you like to see? (recent, featured, or both)"
    input = gets.strip.downcase
    puts ""
    if input == "recent"
      puts "Recent Articles: "
      @articles = Article.all.map { |article| article.type == "Recent" ? article : nil}.compact
      display_list(@articles)
      menu
    elsif input == "featured"
      puts "Featured Articles: "
      @articles = Article.all.map {|article| article.type == "Featured" ? article : nil}.compact
      display_list(@articles)
      menu
    elsif input == "both"
      puts "All articles: "
      @articles = Article.all
      display_list(@articles)
      menu
    elsif input == "exit"
      puts GOODBYE
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
    puts "Enter the number of the article you want to see, type 'list' to choose a new list of articles or type 'exit': "
    input = gets.strip.downcase
    if input.to_i > 0 && input.to_i < @articles.length + 1
      article = @articles[input.to_i - 1]
      display_article(article)
    elsif input == "list"
      list_articles
    elsif input == "exit"
      puts GOODBYE
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
    print "\n\t"
    size_article(article.body).each { |sentence| print sentence}
    if article.youtube_links
      puts "\nYoutube Links:"
      article.youtube_links.each{ |link|
        puts link
      }
    end
    puts "Press any key to find another article or 'exit' to exit."
    input = gets.strip.downcase
    if input == "exit"
      puts GOODBYE
    else
      list_articles
    end
  end

  ##
  # => Sizes thew article to keep it in a managable condition for the user to read
  ##
  def size_article(string)
    sentences = []
    iterator = 1
    num_times = string.size / 103
    sentence_chars = string.chars
    num_times.times do
      if iterator == 1
        sentence = sentence_chars.shift(95).join("") + "\n"
        sentences << sentence
      else
        sentence = sentence_chars.shift(103).join("") + "\n"
        sentences << sentence
      end
      iterator += 1
    end
    sentences
  end
end
