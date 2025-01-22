# Dev Notes:
- created at: 2022-01-21
- updated at: 2022-01-22

My approach:
- Handling this solution in 2 methods: #scrape_artwork, #missing_data_warning
- I used Nokogiri for parsing HTML, felt like the a sensible approach to me.
- We manually pass a file path to a global variable for testing HTML
- Added Basic logging for visibility
- Added a custom warn method for the missing data during scraping
- Added error handling for most common errors
- Handled santizing data for the missing data warning
- Added addtional HTML test data for better testing. (I added mondrian and monet)
- I noticed there was a div(the carrousel), so I targeted this area of the dom.
- The div contains all the data we need related to paintings, `name`, `extensions` array (date), Google `link` and `image`

targeted this div using this identifier:
  data-attrid="kc:/visual_art/visual_artist:works

Run solution.rb in terminal:
  ruby solution.rb

- *** Make sure you run solution.rb at root of the project
- *** You need to manually update the file path in the global variable

# How does this works?
- Add a file path to the global variable, the file should have the html of the google search results page
- The #scrap_artwork is the meat and potatoes, it scrapes the data from the page, and returns an array of hashes
- #scrap_artwork won't add incomplete data and will skip an entry(preserving data integrity), we need to find all 4 (painting_name, year, google_link, image)
- #scrap_artwork concats the google_link, which makes it easier to open in a browser

# RSPEC Testing:
 Run tests in terminal:
   rspec ./spec/<ADD TEST HERE>.rb
   or 
   bundle exec rspec ./spec/<ADD TEST HERE>.rb

- van_gogh_test_spec.rb, this is my base test suite, it also loads the van_gogh-paintings.html
- mondrian_test_spec.rb, this set uses a different google search, loads the mondrian-paintings.html
- monet_test_spec.rb, this test suite uses another different google search, loads the monet-paintings.html

# Added HTML Test Data:
- /home/sambi85/Projects/code-challenge/files/monet-paintings.html
- /home/sambi85/Projects/code-challenge/files/mondrian-paintings.html

# References:
 - Nokogiri, parsing html => https://nokogiri.org/tutorials/parsing_an_html_xml_document.html
 - Stack Overflow => https://stackoverflow.com/questions/2554909/method-to-parse-html-document-in-ruby