require 'spec_helper'

RSpec.describe Importer do

  let!(:importer) { Importer.new("Fixtures", "username", "123456",
                    deleteAfterTransfer: "no"
                    )
                  }
  let!(:xml_string) { VCR.use_cassette("fixtures_feed") { importer.get_feed } }


  describe ".get_feed" do

    it "should return an XML type document" do
      expect(xml_string.class).to eq Nokogiri::XML::Document
    end

    it "should include bet radar data" do
      expect(xml_string.root.name).to eq("BetradarBetData")
      expect(xml_string.xpath("//Sports")).to_not be_empty
    end
  end
end
