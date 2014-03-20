class GrabData
	def self.grab_joke(joke_url)
		joke = Joke.new
		page_joke = Nokogiri::HTML(open(joke_url),nil,'GBK')

		jokes_content = ""
		page_joke.css('span#text110 p').each do |content|
			jokes_content << content.inner_text << "\n"
			
		end
		other_urls = ""

		page_joke.css('div.page a').each do |joke_url|
			temp_url = joke_url["href"]
			
			temp_url.gsub!('../..', 'http://www.jokeji.cn')

			other_urls << temp_url << " "#str.split(',')没有参数默认空格分割为数组
		end

		temp_tilte = page_joke.css('div.mob_left_b2 h1')[0].text
		

	    joke.title = temp_tilte[temp_tilte.rindex(">")+1,temp_tilte.length]
		joke.content = jokes_content
		joke.url = joke_url
		joke.other_urls = other_urls
		return joke

	end

	def self.grab_cartoon(cartoon_url)
		
		cartoon = Cartoon.new
		page_cartoon = Nokogiri::HTML(open(cartoon_url))
		
		other_urls =  "#{page_cartoon.css('div.zw_page1 a')[0]['href']} #{page_cartoon.css('div.zw_page2 a')[0]['href']} #{page_cartoon.css('div.zw_page3 a')[0]['href']}"

		cartoon.title = page_cartoon.css('div#imgshowdiv img')[0]['alt']
		cartoon.description = page_cartoon.css('div#imgshowdiv span')[0].text
		cartoon.picture_url = page_cartoon.css('div#imgshowdiv img')[0]['src']
		cartoon.url = cartoon_url
		cartoon.other_urls = other_urls

		return cartoon		
	end
end