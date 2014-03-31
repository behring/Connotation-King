module DBAdd
  def self.add_user_data(user)
    User.create(identity_user: user.identity_user,nickname: user.nickname,
                input_content:user.input_content,
                data_type:user.data_type,data_id:user.data_id)
  end

  def self.add_music(music)
    Music.create(singer: music.singer, song: music.song,url: music.url,durl: music.durl)
  end
  
end

