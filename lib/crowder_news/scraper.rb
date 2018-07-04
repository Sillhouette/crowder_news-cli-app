##
# => Scraper scrapes the articles from the front page of www.louderwithcrowder.com
#    Scrapes the data from each article to be displayed to the user via CLI
##
class Scraper

  @@url = "https://www.louderwithcrowder.com"

  ##
  # => This method iniates the scrape from our website
  ##
  def self.initiate_scrape
    Article.create_from_collection(self.scrape_featured)
    Article.create_from_collection(self.scrape_recent)

    spinner = TTY::Spinner.new("[:spinner] Processing article details...", format: :dots)
    spinner.auto_spin

    Article.all.each {|article|
      details = self.scrape_details(article.link)
      article.add_details(details)
    }

    spinner.success("\n\tArticle details processed!")
  end

  ##
  # => Scrapes the featured articles from LwC
  ##
  def self.scrape_featured
    spinner = TTY::Spinner.new("[:spinner] Obtaining featured articles...", format: :dots)
    spinner.auto_spin

    doc = Nokogiri::HTML(open(@@url))

    articles = []

    doc.css("div.lwc-featured").each {|featured_article|
      featured_article.css(".featured-box").each { |box|
        title = box.css("h3.featured-title a").text
        link = box.css("h3.featured-title a").attribute("href").value
        excerpt = box.css("p.lwc-excerpt").text
        type = "Featured"
        articles << {:title => title, :link => link, :excerpt => excerpt, :type => type}
      }
    }
    spinner.success("\n\tFeatured articles obtained!")
    articles
  end

  ##
  # => Scrapes the recent articles from LwC
  ##
  def self.scrape_recent
    spinner = TTY::Spinner.new("[:spinner] Obtaining featured articles...", format: :dots)
    spinner.auto_spin

    doc = Nokogiri::HTML(open(@@url))

    articles = []

    doc.css("div.lwc-recent").each {|article|
      article.css(".recent-box").each { |box|
        title = box.css("h3.recent-title a").text
        link = box.css("h3.recent-title a").attribute("href").value
        type = "Recent"
        excerpt = ""
        articles << {:title => title, :link => link, :excerpt => excerpt, :type => type}
      }
    }
    spinner.success("\n\tRecent articles obtained!")
    articles
  end

  ##
  # => Pulls the articles details from each article url so we can complete out Article objects
  ##
  def self.scrape_details(article_url)
    doc = Nokogiri::HTML(open(article_url))

    article_info = {}

    article_info[:author] = doc.css("h2 span.lwc-author").text
    article_info[:date] = doc.css("h2 span.lwc-date").text
    article_info[:body] = doc.css("p").text
    article_info[:youtube_links] = []
    doc.css("div.fluid-width-video-wrapper").each { |wrapper|
      article_info[:youtube_links] << wrapper.css("iframe").attribute("src").value
    }
    article_info
  end

end
