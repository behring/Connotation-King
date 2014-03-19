class GrabData
	def self.grab_joke(joke_url)
		 page_joke = Nokogiri::HTML(open(joke_url),nil,'GBK')
		 jokes = Array.new
		 page_joke.css('#text110 p').each do |joke|
		 	jokes.push(joke.inner_text)
		 end
		 return jokes

	end

	def self.grab_cartoon(cartoon_url)
		page_cartoon = Nokogiri::HTML(open(cartoon_url))
		cartoon_info = Hash.new
		cartoon_info[:title] = page_cartoon.css('div#imgshowdiv img')[0]['alt']
		cartoon_info[:description] = page_cartoon.css('div#imgshowdiv span')[0].text
		cartoon_info[:picture_url] = css('div#imgshowdiv img')[0]['src']
		return cartoon_info		
	end
end