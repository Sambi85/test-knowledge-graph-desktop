describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Oakmont Family Dental" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=Oakmont+Family+Dental&location=Eugene%2C+OR%2C+Oregon%2C+United+States&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains Knowledge Graph hash" do
      expect(@json["knowledge_graph"]).to be_an(Hash)
    end

    it "contains correct tile" do
      expect(@json["knowledge_graph"]["title"]).to eq("Oakmont Family Dental")
    end

    it "contains correct website" do
      expect(@json["knowledge_graph"]["website"]).to eq("https://www.oakmontfamilydental.com/")
    end

    it "contains ratings" do
      expect(@json["knowledge_graph"]["rating"]).to be_an(Float)
    end

    it "contains review count" do
      expect(@json["knowledge_graph"]["review_count"]).to be_an(Integer)
    end

    it "contains local map" do
      expect(@json["knowledge_graph"]["local_map"]).to be_an(Hash)
    end

    it "contains local map image" do
      expect(@json["knowledge_graph"]["local_map"]["image"]).to be_an(String)
    end

    it "contains local map link" do
      expect(@json["knowledge_graph"]["local_map"]["link"]).to be_an(String)
    end

    it "contains local map gps coordinates" do
      expect(@json["knowledge_graph"]["local_map"]["gps_coordinates"]).to be_an(Hash)
    end

  end

end