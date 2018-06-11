class Scraper
  attr_accessor :url

  @url = "https://www.louderwithcrowder.com"

  def self.scrape_featured
    doc = Nokogiri::HTML(open(@url))
    articles = []
    doc.css("div.lwc-featured").each {|featured_article|
      featured_article.css(".featured-box").each { |box|
        title = box.css("h3.featured-title a").text
        link = box.css("h3.featured-title a").attribute("href").value
        excerpt = box.css("p.lwc-excerpt").text
        type = "Featured"
        articles << {:title = title, :link = link, :excerpt = excerpt, :type = type}
      }
    }
    articles
  end

  def self.scrape_recent
    doc = Nokogiri::HTML(open(@url))
    articles = []
    doc.css("div.lwc-recent").each {|article|
      article.css(".recent-box").each { |box|
        title = box.css("h3.recent-title a").text
        link = box.css("h3.recent-title a").attribute("href").value
        article_type = "Recent"
        excerpt = ""
        articles << {:title = title, :link = link, :excerpt = excerpt, :type = type}
      }
    }
    articles
  end

  def self.scrape_details(url)
    doc = Nokogiri::HTML(open(url))
  end

end
