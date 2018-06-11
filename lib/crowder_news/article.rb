class CrowderNews::Article

  attr_accessor :title, :author, :date, :body, :URL, :article_link, :excerpt, :article_type

  def self.today
    #scrape crowder and return deals based on the data
    self.scrape_article
  end

  def self.scrape_article
    articles = []

    articles << self.scrape_featured
    articles << self.scrape_recent
    # Go to crowder, find the articles
    #extract the properties
    #instantiate an articles

    articles
  end

  def self.scrape_featured
    doc = Nokogiri::HTML(open("https://www.louderwithcrowder.com"))
    this_article = self.new
    doc.css("div.lwc-featured").each {|article|
      article.css(".featured-box").each { |box|
        this_article.title = box.css("h3.featured-title a").text
        this_article.article_link = box.css("h3.featured-title a").attribute("href").value
        this_article.excerpt = box.css("p.lwc-excerpt").text
        this_article.article_type = "Featured"
      }
    }
    this_article
  end

  def self.scrape_recent
    doc = Nokogiri::HTML(open("https://www.louderwithcrowder.com"))
    this_article = self.new
    doc.css("div.lwc-recent").each {|article|
      article.css(".recent-box").each { |box|
        this_article.title = box.css("h3.recent-title a").text
        this_article.article_link = box.css("h3.recent-title a").attribute("href").value
        this_article.article_type = "Recent"
        this_article.excerpt = ""
      }
    }
    this_article
  end

end
