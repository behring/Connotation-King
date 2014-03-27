module DBAdd
  def self.add_joke(joke)
    Joke.create(title: joke.title,content: joke.content, url: joke.url, other_urls: joke.other_urls)
  end

  def self.add_cartoon(cartoon)
    Cartoon.create(title: cartoon.title, description: cartoon.description,
                   picture_url: cartoon.picture_url,url: cartoon.url, other_urls: cartoon.other_urls)
  end


  def self.add_jzw(jzw)
    Jzw.create(page_row_number: jzw.page_row_number, qustion: jzw.qustion,
               answer: jzw.answer)
  end

  def self.add_music(music)
    Music.create(singer: music.singer, song: music.song,url: music.url,durl: music.durl)
  end

end