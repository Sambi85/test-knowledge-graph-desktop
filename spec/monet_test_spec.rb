require 'nokogiri'
require 'rspec'
require_relative '../solution.rb'

RSpec.describe 'scrap_artwork' do
  let(:valid_html) { File.read(
    '/home/sambi85/Projects/code-challenge/files/monet-paintings.html'
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

  end
end
