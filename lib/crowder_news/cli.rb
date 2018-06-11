class CrowderNews::CLI

  attr_accessor :articles

  def call
    CrowderNews::Scraper.initiate_scrape
    puts "Welcome to Today on Crowder!"
    list_articles
    menu
  end

  def list_articles
    input = nil
    puts "Choose one: recent, featured, or both"
    input = gets.strip.downcase
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
      list_articles
    end
    display_list(@articles)
  end

  def display_list(articles)
    articles.each.with_index(1) do |article, index|
      puts "#{index}. #{article.title}"
      if(article.excerpt != "")
        puts "    #{article.excerpt[0...104]}..."
      end
    end
  end

  def display_article(article)
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

  def menu
    input = nil
    while input != 'exit'
      puts "Enter the number of the article you want to see, type list to see the articles again or type exit: "
      input = gets.strip.downcase
      if input.to_i > 0
        article = @articles[input.to_i - 1]
        display_article(article)
      elsif input == "list"
        list_articles
      elsif input == "exit"
        goodbye
      else
        puts "Please type a valid command."
      end
    end
  end

  def goodbye
    puts "See you next time!"
  end

end
