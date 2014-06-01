module DBAdd
  def self.add_user_data(user)
    User.create(identity_user: user.identity_user,nickname: user.nickname,
                input_content:user.input_content,
                data_type:user.data_type,data_id:user.data_id)
  end

  def self.add_music(music)
    Music.create(singer: music.singer, song: music.song,url: music.url,durl: music.durl)
  end

  def self.add_book(book)
    Book.create(volume_number:book.volume_number, cover_url: book.cover_url, book_url: book.book_url,book_size: book.book_size)
  end

  #只要邮箱认证成功，就是一个新用户，只是昵称还不知道
  def self.add_client_user(client_user)
    ClientUser.create(token: client_user.token, nickname: client_user.nickname, email: client_user.email,code: client_user.code)
  end

end

