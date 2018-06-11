class CrowderNews::CLI

  def call
    list_deals
    menu
    goodbye
  end

  def list_deals
    puts "Today's news on Crowder: "
    @articles = CrowderNews::Article.today
    @articles.each.with_index(1) do |article, index|
      puts "#{index}. #{article.article_type} - #{article.title}"
      if(article.excerpt != "")
        puts "    #{article.excerpt}"
      end
    end
  end

  def menu
    input = nil
    while input != 'exit'
      puts "Enter the number of the article you want to see or type list to see the articles again or type exit: "
      input = gets.strip.downcase
      if input.to_i > 0
        the_article = @articles[input.to_i - 1]
        puts "#{the_article.title}"
      elsif input == "list"
        list_deals
      else
        puts "Please type a valid command."
      end
    end
  end

  def goodbye
    puts "See you next time!"
  end

end
