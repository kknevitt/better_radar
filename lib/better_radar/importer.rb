class Importer

  URL = "https://www.betradar.com/betradar/getXmlFeed.php"
  PARAMS =  {
              bookmakerName: "UserName",
              xmlFeedName: "Fixtures",
              deleteAfterTransfer: "no",
              key: "123456"
            }

  def self.get_feed
    @xml_string = RestClient.get URL, :params => PARAMS
  end
end
