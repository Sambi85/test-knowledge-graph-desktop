require 'nokogiri'
require 'rspec'
require_relative '../solution.rb'

RSpec.describe 'scrap_artwork' do
  let(:valid_html) { File.read(
    '/home/sambi85/Projects/code-challenge/files/van-gogh-paintings.html'
  ) }
  let(:doc) { Nokogiri::HTML(valid_html) }
  let(:target_div) { doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a') }

  describe '#scrap_artwork' do
    context 'when the HTML contains valid links' do
      it 'returns an array of paintings with name, year, and google link' do
        results = scrap_artwork(target_div)

        expect(results).to be_an(Array)
        expect(results.size).to be > 0
        expect(results.first).to have_key(:name)
        expect(results.first).to have_key(:year)
        expect(results.first).to have_key(:google_link)
        expect(results.first).to have_key(:thumbnail)
      end

      it 'does not have duplicate entries' do
        results = scrap_artwork(target_div)

        expect(results.uniq.size).to eq(results.size)
      end
    end

    context 'when the HTML is missing required fields (painting name or year)' do
      it 'returns an empty array if any required field is missing' do
        invalid_html = '<a href="/search?...."><div class="missing-data"></div></a>'
        doc_invalid = Nokogiri::HTML(invalid_html)
        target_div_invalid = doc_invalid.css('a')

        results = scrap_artwork(target_div_invalid)
        expect(results).to eq([])
      end
    end

    context 'when an error occurs during scraping' do
      it 'rescues errors and returns an empty array' do
        allow(target_div).to receive(:each).and_raise(StandardError, 'Test error')

        results = scrap_artwork(target_div)

        expect(results).to eq([])
      end
    end

    context 'when the HTML is empty or contains no links' do
      it 'returns an empty array' do
        allow(target_div).to receive(:each).and_raise(StandardError, 'Test error')
        empty_html = '<div></div>'
        doc_empty = Nokogiri::HTML(empty_html)
        target_div_empty = doc_empty.css('a')

        results = scrap_artwork(target_div_empty)
        expect(results).to eq([])
      end
    end
  end
end
