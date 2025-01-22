describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Record Den" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=Record+Den&location=Eugene%2C+OR%2C+Oregon%2C+United+States&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains Knowledge Graph hash" do
      expect(@json["knowledge_graph"]).to be_an(Hash)
    end

    it "title" do
      expect(@json["knowledge_graph"]["title"]).to be_a(String)
      expect(@json["knowledge_graph"]["title"]).to_not be_empty
    end

    it "type" do
      expect(@json["knowledge_graph"]["type"]).to be_a(String)
      expect(@json["knowledge_graph"]["type"]).to_not be_empty
    end

    it "website" do
      expect(@json["knowledge_graph"]["website"]).to be_a(String)
      expect(@json["knowledge_graph"]["website"]).to_not be_empty
    end

    it "rating" do
      expect(@json["knowledge_graph"]["rating"]).to be_a(Float)
    end

    it "review_count" do
      expect(@json["knowledge_graph"]["review_count"]).to be_a(Integer)
    end

    it "address" do
      expect(@json["knowledge_graph"]["address"]).to be_a(String)
      expect(@json["knowledge_graph"]["address"]).to_not be_empty
    end

    it "hours" do
      expect(@json["knowledge_graph"]["hours"]).to be_a(String)
      expect(@json["knowledge_graph"]["hours"]).to_not be_empty
    end

    it "phone" do
      expect(@json["knowledge_graph"]["phone"]).to be_a(String)
      expect(@json["knowledge_graph"]["phone"]).to_not be_empty
    end

    it "unclaimed_listing" do
      expect(@json["knowledge_graph"]["unclaimed_listing"]).to be(true)
    end

    it "people_also_search_for" do
      expect(@json["knowledge_graph"]["people_also_search_for"]).to be_a(Array)
      expect(@json["knowledge_graph"]["people_also_search_for"]).to_not be_empty
    end

  end

end