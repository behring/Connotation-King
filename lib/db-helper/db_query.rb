module DBQuery

  def self.count_joke
    Joke.count
  end

  def self.count_cartoon
    Cartoon.count
  end

  def self.count_jzw
    Jzw.count
  end

  def self.count_music
    Music.count
  end


  def self.get_random_joke_url
    if Joke.count>0
      # offset = Random.rand(Joke.count)
      # random_joke = Joke.first(:offset => offset)
      random_joke = Joke.last
      if random_joke.other_urls != nil
        other_urls_array = random_joke.other_urls.split
        random_number = Random.rand(0..1)
        other_urls_array[1] #1表示下一篇笑话 0表示上一篇笑话
      else
        nil
      end
    else
      nil
    end
  end


  def self.get_random_cartoon_url
    if Cartoon.count>0
      # offset = Random.rand(Cartoon.count)
      # random_cartoon = Cartoon.first(:offset => offset)
      random_cartoon = Cartoon.last
      if random_cartoon.other_urls != nil
        other_urls_array = random_cartoon.other_urls.split
        random_number = Random.rand(0..2)
        other_urls_array[2] #2表示下一个漫画 0表示上一个漫画 1表示随机一个漫画
      else
        nil
      end
    else
      nil
    end
  end


  def self.get_jzw_answer(page_row_number)
    Jzw.find_by(:page_row_number => page_row_number).answer
  end


  def self.get_music(singer,song)
    music = Music.where("singer = ? AND song = ?",singer, song).first
  end
end