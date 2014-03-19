require_relative '../lib/env'
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
      # page = Nokogiri::HTML(open("http://www.xiaojiulou.com/sexi/3639.html"))   

      cartoon_info = GrabData.grab_cartoon("http://www.xiaojiulou.com/sexi/3639.html")

      [
        {
         :title => cartoon_info[:title],
         :description => cartoon_info[:description],
         :picture_url => cartoon_info[:picture_url],
         :url => 'http://connotation-king.herokuapp.com/'
        }
        # ,{
        #  :title => '这是第二个图文消息',
        #  :description => 'desc1',
        #  :picture_url => 'pic url1',
        #  :url => 'url1'
        # }
      ]

    when "2"
        jokes = GrabData.grab_joke("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm")
        jokes_str = ""
        jokes.each do |joke|
          jokes_str << joke << "</br>"
        end  
        jokes_str
    when "3"
      "你发送了如下内容:  #{user_input_content}"
    else
      "回复“?”你就知道啦"
  end

end


on_subscribe do
    "感谢您订阅“内含王”\n
    请回复数字选择您感兴趣的节目：\n
    1 内涵漫画\n
    2 幽默笑话\n
    3 心灵物语\n"
end

on_unsubscribe do
  '欢迎您再次订阅！'
end