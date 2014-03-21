token "connotation_king"


on_text do
  user_input_content = params[:Content].strip
  case user_input_content
    when "?","？"
      "您好,我是内含王,请回复数字选择您感兴趣的节目:
      1 内涵漫画
      2 幽默笑话
      3 心灵物语"
    when "1"
      cartoon_url = DBHelper.get_random_cartoon_url
      if cartoon_url == nil
        cartoon_url = CARTOON_DEFAULT_URL
      end

      cartoon = GrabData.grab_cartoon(cartoon_url)
      DBHelper.add_cartoon(cartoon)
      #需要从数据库查询出来才会有id
      cartoon = Cartoon.find_by url:cartoon.url



      jump_url = "http://connotation-king.herokuapp.com/cartoon/"<<cartoon.id.to_s

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

    when "2"
        joke_url = DBHelper.get_random_joke_url
        if joke_url == nil
          joke_url = JOKE_DEFAULT_URL
        end

        joke = GrabData.grab_joke(joke_url)        
        DBHelper.add_joke(joke)
        joke.content

    when "3"
        
      # "你发送了如下内容:  #{user_input_content}"

      "你发送了如下内容:  #{user_input_content}\n
      笑话数量：#{DBHelper.count_joke}个\n
      漫画数量：#{DBHelper.count_cartoon}个
      "
    else
      "回复“?”你就知道啦"
  end

end


on_subscribe do
    "感谢“张文”订阅“内含王”\n
    请回复数字选择您感兴趣的节目：\n
    1 内涵漫画\n
    2 幽默笑话\n
    3 心灵物语\n"
end

on_unsubscribe do
  '欢迎您再次订阅！'
end