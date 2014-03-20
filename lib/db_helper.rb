class DBHelper

	def self.add_joke(joke)
		Joke.create(title: joke.title,content: joke.content, url: joke.url, other_urls: joke.other_urls)
	end
	def self.count_joke
		return Joke.count
	end





	def self.add_cartoon(cartoon)
		Cartoon.create(title: cartoon.title, description: cartoon.description,
			picture_url: cartoon.picture_url,url: cartoon.url, other_urls: cartoon.other_urls)
	end
	def self.count_cartoon
		return Cartoon.count
	end
end