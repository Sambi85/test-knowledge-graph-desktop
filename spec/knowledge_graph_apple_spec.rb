require 'cgi'

describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Apple" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=Apple&location=Dallas&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains Knowledge Graph hash" do
      expect(@json["knowledge_graph"]).to be_an(Hash)
    end

    it "contains correct title" do
      expect(@json["knowledge_graph"]["title"]).to eq("Apple")
    end

    it "contains a type" do
      expect(@json["knowledge_graph"]["type"]).to_not be_empty
    end

    it "contains correct website" do
      expect(@json["knowledge_graph"]["website"]).to eq("https://www.apple.com/")
    end

    it "contains correct headquarters" do
      expect(@json["knowledge_graph"]["headquarters"]).to eq("Cupertino, CA")
    end

    it "contains correct founded date" do
      expect(@json["knowledge_graph"]["founded"]).to eq("April 1, 1976, Cupertino, CA")
    end

    it "contains correct founders" do
      expect(@json["knowledge_graph"]["founders"]).to eq("Steve Jobs, Steve Wozniak, Ronald Wayne")
    end

  end

end