require 'rubygems'
require 'sinatra'
require 'wei-backend'
require 'nokogiri'
require 'open-uri'

token "connotation_king"



get '/index' do
	"hello sinatra"

# page = Nokogiri::HTML(open("http://www.xiaojiulou.com/sexi/3639.html")) 
#   "#{page.css('div.zw_page1 a')[0]['href']}
#    #{page.css('div.zw_page2 a')[0]['href']}
#    #{page.css('div.zw_page3 a')[0]['href']}"

  page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"),nil,'GBK')  
  p page.css('#text110 p')[0].inner_text

end

get '/' do
  haml :joke
end



on_text do
  user_input_content = params[:Content].strip
  case user_input_content
    when "?","？"
      "您好,我是内含王,请回复数字选择您感兴趣的节目:
      1 内涵漫画
      2 幽默笑话
      3 心灵物语"
    when "1"
      page = Nokogiri::HTML(open("http://www.xiaojiulou.com/sexi/3639.html"))   

      [
        {
         :title => page.css('div#imgshowdiv img')[0]['alt'],
         :description => page.css('div#imgshowdiv span')[0].text,
         :picture_url => page.css('div#imgshowdiv img')[0]['src'],
         :url => 'http://'
        }
        # ,{
        #  :title => '这是第二个图文消息',
        #  :description => 'desc1',
        #  :picture_url => 'pic url1',
        #  :url => 'url1'
        # }
      ]

    when "2"
      # page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"))   
      

      # "#{page.css('span#text110 p')[0].text}
      # #{page.css('span#text110 p')[1].text}
      # #{page.css('span#text110 p')[2].text}
      # #{page.css('span#text110 p')[3].text}"
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
