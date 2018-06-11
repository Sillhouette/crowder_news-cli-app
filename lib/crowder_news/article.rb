class CrowderNews::Article

  attr_accessor :title, :link, :excerpt, :type, :author, :date, :body, :twitter_links, :youtube_links

  @@all = []

  def initialize(article_hash)
    @title = article_hash[:title]
    @link = article_hash[:link]
    @excerpt = article_hash[:excerpt]
    @type = article_hash[:type]

    @@all << self;
  end

  def self.create_from_collection(articles_array)
    articles_array.each { |article|
      self.new(article)
    }
  end

  def self.add_details(details_hash)
    @author = article_hash[:author]
    @date = article_hash[:date]
    @body = article_hash[:body]
    @twitter_links = article_hash[:twitter_links]
    @youtube_links = article_hash[:youtube_links]
  end

  def self.all
    @@all;
  end

end
