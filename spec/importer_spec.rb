require 'spec_helper'

RSpec.describe Importer do

  let!(:importer) { Importer.new("Fixtures", "username", "123456",
                    deleteAfterTransfer: "no"
                    )
                  }
  let!(:xml_data) { VCR.use_cassette("fixtures_feed") { importer.get_feed } }


  describe '#get_feed' do

    it "should return an XML type document" do
      expect(xml_data.class).to eq Nokogiri::XML::Document
    end

    it "should include bet radar data" do
      expect(xml_data.root.name).to eq("BetradarBetData")
      expect(xml_data.xpath("//Sports")).to_not be_empty
    end
  end

  describe '#feed_as_xml' do
    let(:xml_string) { importer.feed_as_xml }
    it 'should convert the xml document to a writeable log' do
      expect(xml_string.class).to eq String
      expect(xml_string).to match(/^\<\?xml/)
    end
  end
end
