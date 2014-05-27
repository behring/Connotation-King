token "zhaolin"


on_text do
  form_user_name = params[:FromUserName]
  user_input_content = params[:Content].strip
  content_type = ContentAnalysis.analysis_content_type(user_input_content)

  case content_type

    when USER_CONTENT_TYPE_WHY
      "您好,我是内含王,请回复数字选择您感兴趣的节目:"\
      "\n1 内涵漫画\n2 幽默笑话\n3 脑筋急转弯\n4 在线听歌\n"\
      "(如果“内含王”没有回复您，那她一定是睡着了或太忙了，请再多发几遍吧!)"

    when USER_CONTENT_TYPE_CARTOON

      cartoon = DBQuery.get_random_cartoon(form_user_name,user_input_content)

      jump_url = "#{SERVER_URL}/cartoon/"<<cartoon.id.to_s
      [
        {
         :title => cartoon.title,
         :description => cartoon.description,
         :picture_url => cartoon.picture_url,
         :url => jump_url
        }
        # ,{
        #  :title => '这是第二个图文消息',
        #  :description => 'desc1',
        #  :picture_url => 'pic url1',
        #  :url => 'url1'
        # }
      ]

    when USER_CONTENT_TYPE_JOKE
        joke = DBQuery.get_random_joke(form_user_name,user_input_content)
        joke.content

    when USER_CONTENT_TYPE_JZW
        jzw = DBQuery.get_random_jzw(form_user_name,user_input_content)
        "#{jzw.question}\n(急转弯编号:#{jzw.id})"

    when USER_CONTENT_TYPE_JZW_ANSWER
        #不传jzw的id，默认返回最后一次急转弯的答案
        answer = DBQuery.get_jzw_answer(form_user_name)
        if answer !=nil
          "#{answer}"
        else
          "很抱歉，没有找到您要的答案哦T_T"
        end

    when USER_CONTENT_TYPE_MUSIC
        #"节目开发中，尽请期待！感谢您关注#内含王#"
        
        "请输入歌手名+歌曲名(例如:张杰+他不懂)"
    when USER_CONTENT_TYPE_MUSIC_SEARCH
        singer_song_array = user_input_content.split('+')
        singer = singer_song_array[0]
        song = singer_song_array[1]
        music = BaiduMusic.get_music(singer,song)
        #waiting interface
        if music!= nil
          {
            :title => music.song,
            :description => music.singer,
            :music_url => music.url,
            :hq_music_url => music.durl
          }
        else
          
            "没有搜索到您要的歌曲，请试试别的吧!\n(歌手名+歌曲名)"
            
        end
        # {
        #   :title => "I miss you",
        #   :description => "behring",
        #   :music_url => "http://zhangmenshiting2.baidu.com/data2/music/2314083/2314083.mp3?xcode=a2e2c5736f784f0a94e3da50e93559ccf0a8144ef99e2140",
        #   :hq_music_url => "http://zhangmenshiting2.baidu.com/data2/music/2314083/2314083.mp3?xcode=a2e2c5736f784f0a94e3da50e93559ccf0a8144ef99e2140"
        #  }         

    when USER_CONTENT_TYPE_CX
     "笑话数量：#{DBQuery.count_joke}个\n漫画数量："\
     "#{DBQuery.count_cartoon}个"\
     "\n急转弯数量：#{DBQuery.count_jzw}个"\
     "\n音乐数量：#{DBQuery.count_music}个"
    else
      "回复“?”你就知道啦"
  end

end


on_subscribe do
    "感谢您订阅“内含王”\n请回复数字选择您感兴趣的节目："\
    "\n1 内涵漫画\n2 幽默笑话\n3 脑筋急转弯\n4.在线听歌"
end

on_unsubscribe do
  '欢迎您再次订阅！'
end