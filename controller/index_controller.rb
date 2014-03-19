get '/index' do
	"hello sinatra"

# page = Nokogiri::HTML(open("http://www.xiaojiulou.com/sexi/3639.html")) 
#   "#{page.css('div.zw_page1 a')[0]['href']}
#    #{page.css('div.zw_page2 a')[0]['href']}
#    #{page.css('div.zw_page3 a')[0]['href']}"

  # page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"),nil,'GBK')  
  # p page.css('#text110 p')[0].inner_text

end

get '/' do
  page = Nokogiri::HTML(open("http://www.jokeji.cn/jokehtml/bxnn/201403172304105.htm"),nil,'GBK')  
  haml :joke,  :locals => { :joke =>page.css('#text110 p')[0].inner_text}
end


