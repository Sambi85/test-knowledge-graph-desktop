require 'cgi'

describe "SerpApi Desktop JSON" do

 # TODO test people_also_search_for_link
 describe "Knowledge Graph for MacDonald's" do

    before :all do
      @response = HTTP.get 'https://serpapi.com/search.json?q=McDonald%27s&location=Dallas&hl=en&gl=us&source=test'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains Knowledge Graph hash" do
      expect(@json["knowledge_graph"]).to be_an(Hash)
    end

    it "has `people_also_search_for` block" do
      expect(@json["knowledge_graph"]["people_also_search_for"]).to be_an(Array)
    end

    describe "has `people_also_search_for` results" do

      before :all do
        @first_alternative = @json["knowledge_graph"]["people_also_search_for"][0]
      end

      it "has a name" do
        expect(@first_alternative["name"]).to_not be_empty
      end

      it "has a link" do
        expect(@first_alternative["link"]).to_not be_empty
      end

      it "has an image" do
        expect(@first_alternative["image"]).to_not be_empty
      end

    end

    it "has `people aslo search for` more link" do
      expect(@json["knowledge_graph"]["people_also_search_for_link"]).to_not be_empty
    end

    describe "opens `people_also_search_for` more results page with stick" do

      before :all do
        people_also_search_for_link = @json["knowledge_graph"]["people_also_search_for_link"]
        stick_parameter = CGI.parse(URI.parse(people_also_search_for_link).query)["stick"][0]
        @response_stick = HTTP.get "https://serpapi.com/search.json?q=McDonald%27s&location=Dallas&hl=en&gl=us&source=test&stick=#{stick_parameter}"
        @json_stick = @response_stick.parse
      end

      it "returns http success" do
        expect(@response_stick.code).to be(200)
      end

      it "contains Knowledge Graph hash" do
        expect(@json_stick["knowledge_graph"]).to be_an(Hash)
      end

      it "has `people_also_search_for for` block" do
        expect(@json_stick["knowledge_graph"]["people_also_search_for"]).to be_an(Array)
      end

      it "has more `people_also_search_for` results" do
        expect(@json_stick["knowledge_graph"]["people_also_search_for"].size).to be > 10
      end

      describe "has `people_also_search_for` first result" do

        before :all do
          @first_alternative = @json_stick["knowledge_graph"]["people_also_search_for"][0]
        end

        it "has a name" do
          expect(@first_alternative["name"]).to_not be_empty
        end

        it "has a link" do
          expect(@first_alternative["link"]).to_not be_empty
        end

        it "has an image" do
          expect(@first_alternative["image"]).to_not be_empty
        end

      end

    end

  end

end