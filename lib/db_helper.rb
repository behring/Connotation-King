class DBHelper

	def self.add_joke(joke)
		Joke.create(title: joke.title,content: joke.content, url: joke.url, other_urls: joke.other_urls)
	
	end
	def self.count_joke
		Joke.count
	end

	def self.get_random_joke_url

		if Joke.count>0
			offset = Random.rand(Joke.count)
			random_joke = Joke.first(:offset => offset)
			if random_joke.other_urls != nil
				other_urls_array = random_joke.other_urls.split
				random_number = Random.rand(0..1)
				other_urls_array[random_number] #1表示下一篇笑话 0表示上一篇笑话
			else
				nil
			end
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

	def self.get_random_cartoon_url
		if Cartoon.count>0
			offset = Random.rand(Cartoon.count)
			random_cartoon = Cartoon.first(:offset => offset)
			if random_cartoon.other_urls != nil
				other_urls_array = random_cartoon.other_urls.split
				random_number = Random.rand(0..2)
				other_urls_array[random_number] #2表示下一个漫画 0表示上一个漫画 1表示随机一个漫画
			else
				nil
			end
		else
			nil
		end
		
	end
end