require 'nokogiri'

# Try different file paths to TEST HTML here...
FILE_PATH = '/home/sambi85/Projects/code-challenge/files/van-gogh-paintings.html'
# FILE_PATH = '/home/sambi85/Projects/code-challenge/files/mondrian-paintings.html'
# FILE_PATH = '/home/sambi85/Projects/code-challenge/files/monet-paintings.html'

def missing_data_warning(href, painting_name, year, thumbnail)
  warn_message = "WARN: missing data for link: #{href.nil? || href.empty? ? 'missing data!' : href}\n" \
                 "name: #{painting_name.nil? || painting_name.empty? ? 'missing data!' : painting_name}\n" \
                 "year: #{year.nil? || year.empty? ? 'missing data!' : year}\n" \
                 "thumbnail: #{thumbnail.nil? || thumbnail.empty? ? 'missing data!' : thumbnail}\n"
  warn_message
end

def scrap_artwork(target_div)
  print "STARTING WEB SCRAPING...\nTarget Path: #{FILE_PATH} \n\n"
  results = []

  begin
    target_div.each do |link|
      href = link['href'] || nil
      painting_name = link.at_css('div div:first-child')&.text || nil
      year = link.at_css('div div:last-child')&.text || nil
      thumbnail = link.at_css('img')&.[]('src') || nil # &.[],  safely tries to access the 'src' attribute of the 'img' tag.

      if href && painting_name && year && thumbnail
        results << {
          name: painting_name.strip,
          year: year.strip,
          google_link: "https://www.google.com#{href}",
          thumbnail: thumbnail
        }
      else
        print missing_data_warning(href, painting_name, year, thumbnail)
      end
    end
  rescue StandardError => e
    print "ERROR: something went wrong during web scraping!\n
         error message: #{e.message}"
    results = []
  end

  results
end

begin
  raw_html_content = File.read(FILE_PATH)
  doc = Nokogiri::HTML(raw_html_content)
  target_div = doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a')
  scraps = scrap_artwork(target_div)
  print "WEB SCRAPING COMPLETE...\nTIME: #{Time.now}\n OBJECTS: #{scraps.size}\n"
rescue Errno::ENOENT
  print "The file at #{FILE_PATH} was not found."
rescue Nokogiri::HTML::SyntaxError => e
  print "There was an error parsing the HTML file: #{e.message}"
rescue StandardError => e
  print "An unexpected error occurred: #{e.message}"
end

puts scraps

# See Dev Notes for more details => /home/sambi85/Projects/code-challenge/dev_notes.md