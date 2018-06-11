class CrowderNews::Scraper
  attr_accessor :url

  @url = "https://www.louderwithcrowder.com"

  def self.initiate_scrape
    CrowderNews::Article.create_from_collection(self.scrape_featured)
    CrowderNews::Article.create_from_collection(self.scrape_recent)
    CrowderNews::Article.all.each {|article|
      details = self.scrape_details(article.link)
      article.add_details(details)
    }
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def self.scrape_featured
    doc = Nokogiri::HTML(open(@url))
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
    articles
  end

  def self.scrape_recent
    doc = Nokogiri::HTML(open(@url))
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
    articles
  end

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
