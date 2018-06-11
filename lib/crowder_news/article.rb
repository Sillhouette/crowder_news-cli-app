class CrowderNews::Article

  attr_accessor :title, :link, :excerpt, :type, :author, :date, :body, :youtube_links

  @@all = []
  @@recents = []
  @@featured = []

  def initialize(article_hash)
    @title = article_hash[:title]
    @link = article_hash[:link]
    @excerpt = article_hash[:excerpt]
    @type = article_hash[:type]

    if @type.downcase == "recent"
      @@recents << self
    elsif @type.downcase == "featured"
      @@featured << self
    end
    @@all << self;
  end

  def self.create_from_collection(articles_array)
      articles_array.each { |hash|
      self.new(hash)
    }
  end

  def add_details(details_hash)
    @author = details_hash[:author]
    @date = details_hash[:date]
    @body = details_hash[:body]
    @youtube_links = details_hash[:youtube_links]
  end

  def self.all
    @@all;
  end

  def self.recents
    @@recents
  end

  def self.featured
    @@featured
  end

end
