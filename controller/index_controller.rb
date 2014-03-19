require 'rubygems'
require 'sinatra'
require 'wei-backend'
token "connotation_king"

get '/index' do
	"hello sinatra"
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
      "你发送了如下内容:  #{user_input_content}"
    when "2"
      "你发送了如下内容:  #{user_input_content}"
    when "3"
      "你发送了如下内容:  #{user_input_content}"
    else
      "回复“?”你就知道啦"
  end

end

# on_text do
#   [{
#        :title => '收到一个文本消息，返回两个图文消息',
#        :description => 'desc',
#        :picture_url => 'pic url',
#        :url => 'url'
#    },
#    {
#        :title => '这是第二个图文消息',
#        :description => 'desc1',
#        :picture_url => 'pic url1',
#        :url => 'url1'
#    }]
# end

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
