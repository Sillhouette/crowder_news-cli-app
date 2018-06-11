class CrowderNews::Article

  attr_accessor :title, :author, :date, :body, :URL, :article_link, :excerpt

  def self.today
    #scrape crowder and return deals based on the data
    self.scrape_article
  end

  def self.scrape_article
    articles = []

    articles << self.scrape_crowder
    # Go to crowder, find the articles
    #extract the properties
    #instantiate an articles

    articles
  end

  def self.scrape_crowder
    doc = Nokogiri::HTML(open("https://www.louderwithcrowder.com"))

    doc.css("div.lwc-featured").each {|article|
      article.css(".featured-box").each { |box|

        title = box.css("h3.featured-title a").text
        article_link = box.css("h3.featured-title a").attribute("href").value
        excerpt = box.css("p.lwc-excerpt").text
        binding.pry
      }
    }
    #title = doc.css("h3.featured-title a").text
    #article link = doc.css("h3.featured-title a").attribute("href").value
    #excerpt = doc.css("p.lwc-excerpt").text
    binding.pry
  end

end
