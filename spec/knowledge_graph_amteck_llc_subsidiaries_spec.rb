describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Amteck LLC subsidiaries" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=Amteck+LLC+subsidiaries&location=Dallas&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains Knowledge Graph hash" do
      expect(@json["knowledge_graph"]).to be_an(Hash)
    end

    it "has `subsidiaries` block" do
      expect(@json["knowledge_graph"]["subsidiaries"]).to be_an(Array)
    end

    describe "has `subsidiaries` results" do

      before :all do
        @first_subsidiary = @json["knowledge_graph"]["subsidiaries"][0]
      end

      it "has a name" do
        expect(@first_subsidiary["name"]).to_not be_empty
      end

      it "has a link" do
        expect(@first_subsidiary["link"]).to_not be_empty
      end

    end

  end

end