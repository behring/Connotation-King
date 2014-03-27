module JokeGrab
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

    DBHelper::DBAdd.add_joke(joke)
    joke

  end

end