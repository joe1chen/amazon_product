# encoding: utf-8
require "spec_helper"

module Sucker
  describe Response do
    before do
      @asins = ["0816614024", "0143105825"]
      worker = Sucker.new(
        :locale => "us",
        :key    => amazon["key"],
        :secret => amazon["secret"])
      worker << {
          "Operation"     => "ItemLookup",
          "IdType"        => "ASIN",
          "ResponseGroup" => ["ItemAttributes", "OfferFull"],
          "ItemId"        => @asins }
      @response = worker.get
    end

    context ".new" do
      it "sets the response body" do
        @response.body.should be_an_instance_of String
      end

      it "sets the response code" do
        @response.code.should == 200
      end

      it "sets the response time" do
        @response.time.should be_an_instance_of Float
      end
    end

    context "#xml" do
      it "returns a Nokogiri document" do
        @response.xml.should be_an_instance_of Nokogiri::XML::Document
      end
    end

    context "#node" do
      it "returns a collection of hashified nodes" do
        response = @response.node("ItemAttributes")
        response.map { |book| book["ISBN"] }.should eql @asins
      end

      it "returns an empty array if there are no matches" do
        response = @response.node("Foo")
        response.should eql []
      end
    end

    context "#to_hash" do
      it "returns a hash" do
        @response.to_hash.should be_an_instance_of Hash
      end

      it "converts a content hash to string" do
        @response.body = "<book><title>A Thousand Plateaus</title></book>"
        @response.to_hash["book"]["title"].should be_an_instance_of String
      end

      it "is aliased as to_h" do
        @response.should respond_to :to_h
        @response.to_h.should eql @response.to_hash
      end

      it "renders French" do
        @response.body = "<Title>L'archéologie du savoir</Title>"
        @response.to_hash["Title"].should eql "L'archéologie du savoir"
      end

      it "renders German" do
        @response.body = "<Title>Kafka: Für eine kleine Literatur</Title>"
        @response.to_hash["Title"].should eql "Kafka: Für eine kleine Literatur"
      end

      it "renders Japanese" do
        @response.body = "<Title>スティーブ・ジョブズ 驚異のプレゼン―人々を惹きつける18の法則</Title>"
        @response.to_hash["Title"].should eql "スティーブ・ジョブズ 驚異のプレゼン―人々を惹きつける18の法則"
      end
    end
  end
end
