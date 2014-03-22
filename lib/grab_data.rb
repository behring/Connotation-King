class GrabData
	def self.grab_joke(url)
		
		joke = Joke.new
		page = Nokogiri::HTML(open(URI.encode(url)),nil,'GBK')

		jokes_content = ""
		page.css('span#text110 p').each do |content|
			jokes_content << content.inner_text << "\n"
			
		end
		other_urls = ""

		page.css('div.page a').each do |joke_url|
			temp_url = joke_url["href"]
			
			temp_url.gsub!('../..', 'http://www.jokeji.cn')

			other_urls << temp_url << " "#str.split(',')没有参数默认空格分割为数组
		end

		temp_tilte = page.css('div.mob_left_b2 h1')[0].text
	    joke.title = temp_tilte[temp_tilte.rindex(">")+1,temp_tilte.length]

		joke.content = jokes_content
		joke.url = url
		joke.other_urls = other_urls

		DBHelper.add_joke(joke)
		joke

	end

	def self.grab_cartoon(url)
		cartoon = Cartoon.new
		
		page = Nokogiri::HTML(open(URI.encode(url)))
		img_node = page.css('div#imgshowdiv img')[0]
		if img_node==nil
			random_cartoon_url = page.css('div.zw_page2 a')[0]['href']
			self.grab_cartoon(random_cartoon_url)

		else
			cartoon.title = img_node['alt']
			cartoon.picture_url = img_node['src']
			other_urls =  "#{page.css('div.zw_page1 a')[0]['href']} #{page.css('div.zw_page2 a')[0]['href']} #{page.css('div.zw_page3 a')[0]['href']}"
			cartoon.description = page.css('div#imgshowdiv span')[0].text
			cartoon.other_urls = other_urls
			cartoon.url = url
		end
		DBHelper.add_cartoon(cartoon)
		cartoon		
	end


	def self.grab_jzw
		#急转弯网站笑话一共74页，url从1到74
		page_number = Random.rand(1..74)
		url = "http://www.2345.com/jzw/#{page_number}.htm"


		page = Nokogiri::HTML(open(URI.encode(url)))

		node_jzw_count = page.css('div.jzw_container ul li').size
		jzw_row_number = Random.rand(node_jzw_count)#包含0不包含node_jzw_count

		#拿到每一个急转弯的节点
		page.css('div.jzw_container ul li').each_with_index do |node_jzw,index|

			#抓取急转弯问题
			node_qustion = node_jzw.css('span')[0].to_s
			qustion = node_qustion.encode("UTF-8")
			#抓取急转弯答案
			node_answer = node_jzw.css('span')[1].to_s
			node_answer = node_answer.encode("UTF-8")
			parser = Nokogiri.parse(node_answer)
			answer = parser.xpath('//a[@onclick]').first.attributes['onclick'].content.match(/'([^']+)/)[1]
			
			jzw = Jzw.new
			jzw.page_row_number= page_number.to_s+"."+index.to_s
			jzw.qustion = qustion
			jzw.answer = answer
			DBHelper.add_jzw(jzw)

			if index == jzw_row_number
				@jzw_return = jzw 
			end
		end
		@jzw_return
	end

end