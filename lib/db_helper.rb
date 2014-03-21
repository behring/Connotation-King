class DBHelper

	def self.add_joke(joke)
		Joke.create(title: joke.title,content: joke.content, url: joke.url, other_urls: joke.other_urls)
	
	end
	def self.count_joke
		Joke.count
	end

	def self.get_last_joke_url
		if Joke.last != nil
			puts "#{Joke.last.other_urls}"
			other_urls_array = Joke.last.other_urls.to_s.split
			other_urls_array[1] #1表示下一篇笑话 0表示上一篇笑话
		else
			nil
		end
	end




	def self.add_cartoon(cartoon)
		Cartoon.create(title: cartoon.title, description: cartoon.description,
			picture_url: cartoon.picture_url,url: cartoon.url, other_urls: cartoon.other_urls)
	end
	def self.count_cartoon
		Cartoon.count
	end

	def self.get_last_cartoon_url
		if Cartoon.last != nil
			other_urls_array = Cartoon.last.other_urls.split
			other_urls_array[1] #2表示下一个漫画 0表示上一个漫画 1表示随机一个漫画
		else
			nil
		end
		
	end
end