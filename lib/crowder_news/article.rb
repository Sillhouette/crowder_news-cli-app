class CrowderNews::Article

  attr_accessor :title, :author, :date, :body, :URL

  def self.today
    #return a bunch of instances of articles
    #puts "1. LGBT Activists Bully Twitter Founder for..."
    #puts "2. Socialist bernie sanders accuses trump of..."
    article_1 = self.new
    article_1.title = "LGBT Activists Bully Twitter Founder for..."
    article_1.author = "author"
    article_1.date = "today"
    article_1.body = "body"
    article_1.URL = "someurl.com"

    article_2 = self.new
    article_2.title = "Socialist bernie sanders accuses trump of..."
    article_2.author = "author_2"
    article_2.date = "today"
    article_2.body = "body_2"
    article_2.URL = "someurl_2.com"

    [article_1, article_2]
  end
end
