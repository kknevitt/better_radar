require 'nokogiri'

class Importer

  URL = "https://www.betradar.com/betradar/getXmlFeed.php"

  attr_accessor :feed_name, :user, :key, :options

  def initialize(feed_name, bookmaker, key, options = {})
    self.feed_name = feed_name
    self.user = bookmaker
    self.key = key

    self.options = options
  end

  def get_feed
    @xml_data = Nokogiri::XML(open(build_url))
  end

  def feed_as_xml
    @xml_data.to_xml if @xml_data
  end

  private

  def build_url
    generated_url = URL << "?"
    feed_arguments.each_with_index do |(key, value), index|
      generated_url << "#{key}=#{value}"
      generated_url << "&" unless index == feed_arguments.length - 1
    end
    generated_url
  end

  def feed_arguments
    args = {
      bookmakerName: self.user,
      xmlFeedName: self.feed_name,
      key: self.key
    }
    args.merge!(options)
  end

end
