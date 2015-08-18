require 'spec_helper'

RSpec.describe Importer do

  let!(:importer) { Importer }

  describe ".get_feed" do
    let(:xml_string) { VCR.use_cassette("feed") { importer.get_feed } }

    it "should return an xml type string" do
      expect(xml_string).to match(/^\<\?xml/)
    end

    it "should include bet radar data" do
      expect(xml_string).to match(/<BetradarBetData>/)
      expect(xml_string).to match(/<Sports/)
    end
  end
end
