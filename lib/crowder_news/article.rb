##
# => Handles Article object creation
##
class Article
  # => Accessors for article details
  attr_accessor :title, :link, :excerpt, :type, :author, :date, :body, :youtube_links

  # => Set each of our Class arrays to a blank array
  @@all = []
  ##
  # => Creates new Article objects
  ##
  def initialize(article_hash)
    @title = article_hash[:title]
    @link = article_hash[:link]
    @excerpt = article_hash[:excerpt]
    @type = article_hash[:type]

    @@all << self;
  end

  ##
  # => Creates articles from a hash of article information
  ##
  def self.create_from_collection(articles_array)
    articles_array.each { |hash|
      self.new(hash)
    }
  end

  ##
  # => Adds the additional details to our Article object
  ##
  def add_details(details_hash)
    @author = details_hash[:author]
    @date = details_hash[:date]
    @body = details_hash[:body]
    @youtube_links = details_hash[:youtube_links]
  end

  # => Getter returns all of our article objects
  def self.all
    @@all;
  end

end
