class CrowderNews::CLI

  def call
    list_deals;
    menu;
    goodbye
  end

  def list_deals
    puts "Today's news on Crowder: "
    puts "1. LGBT Activists Bully Twitter Founder for..."
    puts "2. Socialist bernie sanders accuses trump of..."
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the article you want to see or type list to see the articles again or type exit: "
      input = gets.strip.downcase
      case input
      when "1"
        puts "more info on article 1..."
      when "2"
        puts "more infor on article 2..."
      when "list"
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
